class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.datetime :deadline
      t.datetime :date_completed
      t.string :priority_level

      t.timestamps
    end
  end
end
