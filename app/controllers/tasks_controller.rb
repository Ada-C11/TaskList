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
    @task = Task.new(task_params)

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
    @task = Task.find_by(id: params[:id])
    # redirect_to task_path

    @task.update(task_params)

    redirect_to task_path(@task)
  end

  private

  def task_params
    return params.require(:task).permit(:name, :completion_date, :description)
  end
end
