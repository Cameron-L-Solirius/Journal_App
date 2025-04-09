class Investment < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :initial_deposit, :monthly_contribution, :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
