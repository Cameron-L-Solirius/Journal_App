class InvestmentsController < ApplicationController
  def index
    @investments = Investment.all
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

  def edit
    @investment = Investment.find(params[:id])
  end

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

  private
  # Required parameters for the add investment functionality (will need validators elsewhere)
  def investment_params
      params.require(:investment).permit(:name, :initial_deposit, :monthly_contribution, :rate, :duration)
  end
end
