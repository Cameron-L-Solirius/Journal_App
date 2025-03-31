class DropDummyModels < ActiveRecord::Migration[7.2]
  def up
    drop_table :dummy_models
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
