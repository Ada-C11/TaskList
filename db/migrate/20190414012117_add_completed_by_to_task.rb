class AddCompletedByToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completed_on, :date
  end
end
