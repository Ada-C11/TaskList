class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:name)
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    redirect_to tasks_path if @task.nil?
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    if task.name == ""
      redirect_to tasks_path
    elsif task.save
      redirect_to task_path(task.id)
    else
      head :bad_request
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    redirect_to tasks_path if @task.nil?
  end

  def update
    task = Task.find_by(id: params[:id])

    if task.nil?
      redirect_to tasks_path
    else
      task.update(task_params)
      redirect_to task_path
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      redirect_to tasks_path
    else
      task.destroy
      redirect_to tasks_path
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
    elsif !task.completed
      task.completed = true
      task.completion_date = Date.today
      task.save
    else
      task.completed = false
      task.save
    end
    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
end
