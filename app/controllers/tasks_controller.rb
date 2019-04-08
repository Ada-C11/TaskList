TASKS = [
  "Go to the store",
  "Do homework",
  "Go grocery shopping",
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
