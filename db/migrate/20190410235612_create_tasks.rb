class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.boolean :complete
      t.string :complete_date

      t.timestamps
    end
  end
end
