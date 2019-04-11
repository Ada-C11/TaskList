class GetRidOfCompletionDate < ActiveRecord::Migration[5.2]
  def change
    # emove_column(table_name, column_name)
    remove_column(:tasks, :completion_date )
  end
end
