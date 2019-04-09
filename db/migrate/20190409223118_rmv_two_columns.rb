class RmvTwoColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tasks, :name)
    remove_column(:tasks, :completion_date)
  end
end
