class Investment < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :initial_deposit, :monthly_contribution, :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def calculate_growth
    Money.default_currency = "GBP"
    current_amount = Money.new(initial_deposit * 100) # Convert to pennies
    (1..duration).each do |year|
      current_amount += current_amount * (rate / 100)
      # Use current_amount.format to display the value
    end
  end
end
