class DropTasks < ActiveRecord::Migration[5.2]
  def change
    drop_table :tasks
  end
end
