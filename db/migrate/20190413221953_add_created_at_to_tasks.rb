class AddCreatedAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :created_when, :datetime, default: DateTime.now
  end
end
