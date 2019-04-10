class TasksController < ApplicationController
  # TASKS = [
  #   { task: "Laundry", date: "04-5-18" },
  #   { task: "Meal Prep", date: "04-5-19" },
  # ]

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]

    @task = Task.find(task_id)

    head :not_found unless @task
  end
end
