class RenameColumnCompletedByInTask2 < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :completed_by, :complete_by
  end
end
