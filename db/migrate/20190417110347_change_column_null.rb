class ChangeColumnNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:tasks, :completed_at, true)
  end
end
