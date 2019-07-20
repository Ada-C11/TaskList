class AddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :descriptions, :string
    add_column :tasks, :completion_date, :string
  end
end
