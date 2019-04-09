class AddDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :date, :string
  end
end
