class InvestmentsController < ApplicationController
  def index
    @investments = Investment.all
  end

  def new
    @investment = Investment.new()
  end

  def add_investment
    @investment = Investment.new()
    if @investment.save
      redirect_to route_for("/investments")
    else

    end
  end
  private

  def investment_params
      params.require(:investment).permit(:name, :initial_deposit, :monthly_contribution, :rate, :duration)
  end
end
