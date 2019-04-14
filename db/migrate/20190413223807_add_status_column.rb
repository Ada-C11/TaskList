class AddStatusColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :boolean
  end
end
