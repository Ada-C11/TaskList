class AddCompletionDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completiondate, :string
  end
end
