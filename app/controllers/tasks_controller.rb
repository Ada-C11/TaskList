class TasksController < ApplicationController
  TASKS = [
    {name: "Practice CSS"},
    {name: "Celebrate Wedding Anniversary"},
    {name: "Stress Eat!"},
  ]

  def index
    @tasks = TASKS
  end
end
