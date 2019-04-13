class AddDateCompletedColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :date_completed, :date
  end
end
