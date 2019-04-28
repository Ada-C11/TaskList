class AddCompletionDateColumn < ActiveRecord::Migration[5.2]
  def change
    def change
      change_column(:tasks, :completion_date, :datetime)
    end
  end
end
