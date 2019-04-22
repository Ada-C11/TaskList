class AddCompletionDateToTask < ActiveRecord::Migration[5.2]
  def change
    add_column(:tasks, :completed_at, :string)
  end
end
