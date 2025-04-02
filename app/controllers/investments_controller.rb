class InvestmentsController < ApplicationController
  # after_save :go_to_index
  def index
    @investments = Investment.all
  end

  def new
    @investment = Investment.new()
  end

  # Create method for a new method entry
  def create
    @investment = Investment.new(investment_params)
    if @investment.save
      redirect_to root_url
    else
        render :new
    end
  end

  private
  # Required parameters for the add investment functionality (will need validators elsewhere)
  def investment_params
      params.require(:investment).permit(:name, :initial_deposit, :monthly_contribution, :rate, :duration)
  end

  # def go_to_index
  #   redirect_to index()
  # end
end
