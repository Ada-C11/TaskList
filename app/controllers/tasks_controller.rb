class TasksController < ApplicationController
  # TASKS = [
  #   { task: "PR for CS Fun" },
  #   { task: "TaskList project" },
  # ]

  def index
    @tasks = Task.all
  end
end
