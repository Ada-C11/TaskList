class RemoveCreationDate < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tasks, :creation_date)
  end
end
