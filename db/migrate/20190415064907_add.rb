class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :current_status, :boolean
  end
end
