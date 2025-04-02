class Investment < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :initial_deposit, :monthly_contribution, :rate, :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
