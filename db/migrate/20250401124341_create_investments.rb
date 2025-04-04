class CreateInvestments < ActiveRecord::Migration[7.2]
  def change
    create_table :investments do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.integer :initial_deposit
      t.integer :monthly_contribution
      t.decimal :rate
      t.integer :duration

      t.timestamps
    end
  end
end
