class AddCompletedColumn < ActiveRecord::Migration[5.2]
  def change
    add_column(:tasks, :mark_complete, :boolean)
  end
end
