class ChangeCompletionDate < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tasks, :completion_date, :string)
    add_column(:tasks, :completion_date, :datetime)
  end
end
