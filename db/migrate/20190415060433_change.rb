class Change < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :completion_date, :date
  end
end
