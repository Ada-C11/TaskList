class CreateColumnsForTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :columns_for_tasks do |t|
    end #What is this????
    add_column :tasks, :name, :string
    add_column :tasks, :description, :string
    add_column :tasks, :completion_date, :string
  end
end
