# frozen_string_literal: true

class ChangeColumnDataTypeToTasks < ActiveRecord::Migration[5.2]
  def change
    # change_column(:tasks, :completion_date, :date)
    remove_column(:tasks, :completion_date)
    add_column(:tasks, :completion_date, :date)
  end
end
