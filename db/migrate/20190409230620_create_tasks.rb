class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :description
      t.date :date_due
      t.date :date_completed

      t.timestamps
    end
  end
end
