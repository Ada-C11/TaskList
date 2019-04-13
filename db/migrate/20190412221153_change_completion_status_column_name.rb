class ChangeCompletionStatusColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :completion_status, :completed)
  end
end
