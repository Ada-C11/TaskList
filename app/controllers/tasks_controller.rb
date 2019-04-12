class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to task_path
      flash[:error] = "Could not find task with id: #{params[:id]}"
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
      completion_date: params["task"]["completion_date"],
      status: params["task"]["status"],
    )

    is_successful = task.save
    if is_successful
      redirect_to task_path(task.id)
      flash[:success] = "Task successfully created!"
    else
      redirect_to task_path(task_id)
      flash[:error] = "Cannot create task: #{params[:name]}"
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    task = Task.find_by(id: params[:id])

    is_successful = task.update(task_params)
    if is_successful
      redirect_to task_path(task.id)
    else
      flash[:error] = "Cannot create task: #{params[:name]}"
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date, :status)
  end
end
