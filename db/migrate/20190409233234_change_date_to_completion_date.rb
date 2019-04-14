class ChangeDateToCompletionDate < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :date, :completion_date)
  end
end
