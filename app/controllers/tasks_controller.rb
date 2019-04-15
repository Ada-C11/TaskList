class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    task.save
    redirect_to task_path(task.id)
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    # head :not_found if @task.nil?
    redirect_to tasks_path if @task.nil?
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    redirect_to tasks_path if @task.nil?
  end

  def update
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    unless task
      redirect_to tasks_path
      return
    end
    task.update(task_params)
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

  def toggle_complete
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    unless task
      head :not_found
      return
    end

    if task.completion_date.nil?
      task.update!(completion_date: Date.current)
    else
      task.update!(completion_date: nil)
    end

    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
