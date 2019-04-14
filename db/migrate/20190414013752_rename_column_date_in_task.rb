class RenameColumnDateInTask < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :date, :complete_by
  end
end
