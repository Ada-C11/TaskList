class ChangeDateCompletedTypeTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :date_completed, :timestamp
  end
end
