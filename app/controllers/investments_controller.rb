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
    # @investments = current_user.inevstments
    render :compare_investments
  end

  private
  # Required parameters for the add investment functionality (will need validators elsewhere)
  def investment_params
      params.require(:investment).permit(:name, :initial_deposit, :monthly_contribution, :rate, :duration)
  end
end
