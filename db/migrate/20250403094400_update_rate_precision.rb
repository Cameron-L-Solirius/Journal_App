class UpdateRatePrecision < ActiveRecord::Migration[7.2]
  def change
    change_column :investments, :rate, :decimal, precision: 10, scale: 2
  end
end
