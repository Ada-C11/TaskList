class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path, :flash => {:error => "Could not find task with id: #{task_id}"}
    end
  end

  def new
    @task = Task.new
  end

  def edit
    task_id = (params[:id])

    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path, :flash => {:error => "Could not find task with id: #{task_id}"}
    end
  end

  def update
    task_id = (params[:id])

    @task = Task.find_by(id: task_id)

    if @task
      @task.name = params[:name]
      @task.description = params[:description]

      @task.save

      redirect_to task_path(@task.id)
    else
      redirect_to root_path, :flash => {:error => "Could not find task with id: #{task_id}"}
    end
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
    )

    task.save

    redirect_to task_path(task.id)
  end

  def destroy
    task_id = params[:id]

    task = Task.find_by(id: task_id)

    if task
      task.destroy
      redirect_to tasks_path
    else
      redirect_to root_path, :flash => {:error => "Could not find task with id: #{task_id}"}
    end
  end
end
