class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find(task_id)

    unless @task
      head :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new

    @task.name = params["task"]["name"]
    @task.description = params["task"]["description"]

    @task.save

    redirect_to tasks_path
  end
end
