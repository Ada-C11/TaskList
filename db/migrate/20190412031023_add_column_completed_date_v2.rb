class AddColumnCompletedDateV2 < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completed_date, :datetime
  end
end
