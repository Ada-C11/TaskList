class TasksController < ApplicationController

  # create tasklist hash

  TASKS = [
    {task_name: "complete tasks project", status: "Pending", done_by: "Today"},
    {task_name: "shower", status: "Pending", done_by: "Today"},
    {task_name: "call moma", status: "Pending", done_by: "Today"},

  ]

  def index
    @tasks = Task.all.order(:name)
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
    end
  end

  def new
    @task = Task.new(name: "Type task here...")
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
      completion_date: params["task"]["completion_date"],
    )

    is_successful = task.save

    if is_successful
      redirect_to tasks_path
    else
      # For Rails Week 1, not a requirement (not possible right now?) to test this case in controller tests
      head :not_found
    end
  end
end
