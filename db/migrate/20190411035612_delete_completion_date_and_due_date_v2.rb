class DeleteCompletionDateAndDueDateV2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :completion_date
    remove_column :tasks, :due_date
  end
end
