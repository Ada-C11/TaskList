class UpdateCompleteDateToDateType < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :complete_date
    add_column :tasks, :complete_date, :date
  end
end
