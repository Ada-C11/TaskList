class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new

    unless params["task"]
      render :new, status: :bad_request
      return
    end

    @task.name = params["task"]["name"]
    @task.completion_date = params["task"]["completion_date"]
    @task.description = params["task"]["description"]

    @task.save

    redirect_to tasks_path
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
    end
  end
  
  def update
    redirect_to task_path
  end
  
end
