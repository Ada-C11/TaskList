class ChangeCompletedDataType < ActiveRecord::Migration[5.2]
  def change
    change_column(:tasks, :mark_complete, :boolean)
  end
end
