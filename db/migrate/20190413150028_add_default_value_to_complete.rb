class AddDefaultValueToComplete < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :tasks, :complete, :boolean, default: false
    end

    def down
      change_column :tasks, :complete, :boolean, default: nil
    end
  end
end
