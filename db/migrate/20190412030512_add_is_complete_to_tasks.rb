# frozen_string_literal: true

class AddIsCompleteToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :is_complete, :boolean
  end
end
