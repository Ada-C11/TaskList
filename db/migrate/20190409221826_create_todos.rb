class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :name
      t.string :description
      t.string :completion_date
      t.string :date

      t.timestamps
    end
  end
end
