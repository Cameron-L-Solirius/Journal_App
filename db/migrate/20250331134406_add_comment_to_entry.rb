class AddCommentToEntry < ActiveRecord::Migration[7.2]
  def change
    add_column :entries, :comment, :string
  end
end
