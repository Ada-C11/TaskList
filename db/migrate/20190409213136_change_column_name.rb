class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :completion_ddate, :completion_date
  end
end
