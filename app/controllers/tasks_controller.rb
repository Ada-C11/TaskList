class TasksController < ApplicationController
  TASKS = [
    "Build TaskList Rails App",
    "Move Joyfully",
    "Go Grocery Shopping",
  ]

  def index
    @tasks = TASKS
  end
end
