class ChangeDefaultForCompletionDateAgain < ActiveRecord::Migration[5.2]
  def change
    change_column_default(
      :tasks,
      :completion_date,
      nil
    )
  end
end
