# frozen_string_literal: true

class ChangeCompletionDateDataTypeForTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :completion_date, "date USING completion_date::date"
  end
end
