class UpdateInitialDeposit2 < ActiveRecord::Migration[7.2]
  def change
    change_column :investments, :initial_deposit, :decimal, precision: 10, scale: 2
  end
end
