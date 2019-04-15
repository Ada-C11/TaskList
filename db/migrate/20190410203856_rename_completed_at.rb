class RenameCompletedAt < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tasks, :completed_at)
    add_column(:tasks, :completion_date, :datetime)
  end
end
