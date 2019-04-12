require 'pry'

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
    task = Task.new(
      name: params['task']['name'],
      description: params['task']['description'],
      completion_date: Date.parse(params['task']['completion_date'])
    )

    task.save

    redirect_to tasks_path
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    task.update(task_params)

    redirect_to task_path(task)
  end

  private
  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
