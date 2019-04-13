class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:id)
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
    @task.task_name = "Default task name"
    @task.completed = "true/false"
  end

  def create
    new_task = Task.new(task_params)

    created_successfully = new_task.save

    if created_successfully
      redirect_to task_path(new_task.id)
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

    updated_successfully = task.update(task_params)

    if updated_successfully
      redirect_to task_path(task.id)
    else
      redirect_to tasks_path
    end
  end

  def toggle_complete
    task = Task.find_by(id: params[:id])

    task.completed?
    task.toggle(:completed)
    task.save

    redirect_to tasks_path
  end

  def destroy
    task_to_destroy = Task.find_by(id: params[:id])

    if task_to_destroy.nil?
      head :not_found
    else
      task_to_destroy.destroy
      redirect_to tasks_path
    end
  end

  private

  def task_params
    return params.require(:task).permit(:task_name, :description, :completed)
  end
end
