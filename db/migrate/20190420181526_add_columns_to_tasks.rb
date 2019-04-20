class AddColumnsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, "name", :string
    add_column :tasks, "description", :string
    add_column :tasks, "completed_on", :date
    add_column :tasks, "complete_by", :date
    add_column :tasks, "complete", :boolean
  end
end
