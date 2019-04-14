class ChangeCompletedName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :completed, :completion_date)
  end
end
