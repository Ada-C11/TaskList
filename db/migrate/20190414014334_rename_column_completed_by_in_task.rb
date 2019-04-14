class RenameColumnCompletedByInTask < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :complete_by, :completed_on
  end
end
