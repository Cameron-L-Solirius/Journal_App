class UpdateMonthlyContribution < ActiveRecord::Migration[7.2]
  def change
    change_column :investments, :monthly_contribution, :decimal, precision: 10, scale: 2
  end
end
