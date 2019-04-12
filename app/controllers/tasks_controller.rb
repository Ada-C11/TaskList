class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    puts "Made it"
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
    )

    task.save

    redirect_to tasks_path
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
    end
  end

  def edit
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    unless task
      redirect_to root_path
      return
    end

    task.update(
      name: params["task"]["name"],
      description: params["task"]["description"],
    )

    redirect_to task_path(task)
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    unless task
      head :not_found
      return
    end

    task.destroy

    redirect_to tasks_path
  end
end
