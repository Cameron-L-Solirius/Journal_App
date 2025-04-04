class DropEntries < ActiveRecord::Migration[7.2]
  def up
    drop_table :entries
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
