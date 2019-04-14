class ChangeDatenameBack < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :due_date, :date)
  end
end
