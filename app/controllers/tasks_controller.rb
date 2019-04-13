class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
      return
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

  def edit
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
      return
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    unless task
      redirect_to tasks_path
      return
    end

    task_params = {
      name: params[:task][:name],
      description: params[:task][:description],
    }

    task.update(task_params)

    redirect_to tasks_path
  end

  def destroy
    task = Task.find_by(id: params[:id])

    unless task
      head :not_found
      return
    end

    task.destroy

    redirect_to tasks_path
  end
end
