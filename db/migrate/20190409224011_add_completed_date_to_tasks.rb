class AddCompletedDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completed_date, :date
  end
end
