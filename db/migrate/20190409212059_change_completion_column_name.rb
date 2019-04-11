class ChangeCompletionColumnName < ActiveRecord::Migration[5.2]
  def change
    # rename_column(table_name, old_column, new_column): Renames a column to match the newly given column name.

    rename_column(:tasks, :completion, :completion_date)
  end
end
