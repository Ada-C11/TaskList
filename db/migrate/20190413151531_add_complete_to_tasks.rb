class AddCompleteToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :complete, :boolean, null: false, default: false
  end
end
