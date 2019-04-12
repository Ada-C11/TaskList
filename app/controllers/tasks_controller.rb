class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new(name: "Default Name")
  end

  def create
    task = Task.new(task_params)

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :not_found
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    task.update(task_params)
    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :not_found
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task.nil?
      head :not_found
    else
      task.destroy
      redirect_to tasks_path
    end
  end

  def mark_complete

  end

  private

  def task_params
    #Responsible for returning strong params as Rails wants it
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
