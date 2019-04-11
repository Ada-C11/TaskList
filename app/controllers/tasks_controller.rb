class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    unless @task
      flash[:error] = "Could not find task with id: -1"
      redirect_to "tasks_path"
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new

    @task.name = params["task"]["name"]
    @task.description = params["task"]["description"]
    @task.completion_date = params["task"]["completion_date"]

    is_successful = @task.save

    if is_successful
      redirect_to task_path(@task.id)
    else
      head :not_found
    end
  end
end
