class RemoveCompletionDateFromTasksAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :completion_date, :datetime
  end
end
