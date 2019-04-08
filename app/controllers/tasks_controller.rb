class TasksController < ApplicationController
  TASKS = [
    "task 1", 
    "task 2",
    "task 3",
  ]
  def index
    @tasks = TASKS
  end
end
