class AddCompletionStatusToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completion_status, :boolean
  end
end
