class InvestmentsController < ApplicationController
  def index
    @investments = current_user.investments.all
  end

  def new
    @investment = Investment.new()
  end

  # Create method for a new method entry
  def create
    @investment = Investment.new(investment_params)
    @investment.user_id = current_user.id
    if @investment.save
      redirect_to investments_path, notice: "Investment was successfully created."
    else
      render :add_investment
    end
  end

  # Delete method for investment entry
  def destroy
    @investment = Investment.find(params[:id])
    @investment.destroy
    redirect_to investments_path, notice: "Investment was successfully deleted."
  end

  # Edit method for changing investment details
  def edit
    @investment = Investment.find(params[:id])
  end

  # Update method for updating investment details (find out which is required, this or edit, stable for now)
  def update
    @investment = Investment.find(params[:id])
    @investment.user_id = current_user.id
    if @investment.update(investment_params)
      redirect_to investments_path, notice: "Investment was successfully updated."
    else
      render :add_investment
    end
  end

  # Add investment page
  def add_investment
    @investment = Investment.new()
  end

  # Compare investments page
  def compare
    @investments = current_user.investments
    if params[:investment1_id].present? && params[:investment2_id].present?
      @investment1 = current_user.investments.find(params[:investment1_id])
      @investment2 = current_user.investments.find(params[:investment2_id])

      @chart_data = [
        { name: @investment1.name, data: calculate_multiple_growth(@investment1) },
        { name: @investment2.name, data: calculate_multiple_growth(@investment2) }
      ]
    end
    render :compare_investments
  end

  # Method for multiple investment calculation
  def calculate_multiple_growth(investment)
    monthly_values = {}
    current_amount = investment.initial_deposit
    monthly_rate = investment.rate.to_f / 100 / 12

    (1..investment.duration * 12).each do |month|
      current_amount += (current_amount * monthly_rate) + investment.monthly_contribution
      monthly_values[month] = current_amount.round(2)
    end
    monthly_values
  end

  # Show method for displaying individual graphs
  def show
    @investment = Investment.find(params[:id])
    @chart_data = calculate_growth(@investment)
    @total_contribution = total_contribution(@investment)
    @total_growth = total_growth(@investment)
  end

  # Helps display total contributions in view graph pages
  def total_contribution(investment)
    total_contribution = investment.monthly_contribution * investment.duration * 12
  end

  # Calcilates total growth of a single investment, to be shown on view graph pages
  def total_growth(investment)
    Money.default_currency = "GBP"
    current_amount = Money.new(investment.initial_deposit * 100) # Convert to pennies
    monthly_cont = Money.new(investment.monthly_contribution * 100)
    monthly_rate = investment.rate.to_f / 100 / 12
    total_months = 0
    total_growth = 0

    (1..investment.duration).each do |year|
      (1..12).each do |month|
        total_months += 1
        months_growth = current_amount * monthly_rate
        current_amount += months_growth + monthly_cont
        total_growth += months_growth
      end
    end
    total_growth
  end

  # Method takes cur_amount, for each month in each year:
  # it adds monthly contribution to current amount + interest generated
  # Arr of hashes fed to chartkick linechart helper
  def calculate_growth(investment)
    Money.default_currency = "GBP"
    monthly_values = [ { name: "0", data: investment.initial_deposit } ]
    current_amount = Money.new(investment.initial_deposit * 100) # Convert to pennies
    monthly_cont = Money.new(investment.monthly_contribution * 100)
    monthly_rate = investment.rate.to_f / 100 / 12
    total_months = 0

    # Loop over each year then month -> increment month -> add interest to current amount -> add as entry to monthly_values
    (1..investment.duration).each do |year|
      (1..12).each do |month|
        total_months += 1
        current_amount = add_monthly_growth(current_amount, monthly_rate, monthly_cont)
        monthly_values << { name: "#{total_months}", data: current_amount.to_f.round(2) } # back to pounds
      end
    end
    monthly_values
  end

  # Method for adding monthly growth to current amount
  def add_monthly_growth(current_amount, monthly_rate, monthly_cont)
    current_amount += (current_amount * monthly_rate) + monthly_cont
  end

  private
  # Required parameters for the add investment functionality (will need validators elsewhere)
  def investment_params
      params.require(:investment).permit(:name, :initial_deposit, :monthly_contribution, :rate, :duration)
  end
end
