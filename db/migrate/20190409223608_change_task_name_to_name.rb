class ChangeTaskNameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :task_name, :name)
  end
end
