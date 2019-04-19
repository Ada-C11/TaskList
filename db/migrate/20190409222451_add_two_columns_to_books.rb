class AddTwoColumnsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :name, :string
    add_column :tasks, :completion_date, :integer
  end
end
