TASKS = [
  "Laundry", "Homework", "Grocery shopping",
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
