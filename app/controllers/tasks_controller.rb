class TasksController < ApplicationController
  before_action :set_task, except: :create

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

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless task
      head :not_found
      return
    end

    task.destroy

    redirect_to tasks_path
  end

  def complete
    @task = Task.find_by(id: params[:id])

    @task.update_attribute(:completed_at, Time.now)
    # redirect_to task_path

    redirect_to task_path(@task.id), notice: "Task marked completed"
  end

  private

  def task_params
    return params.permit(:name, :completion_date, :description, :completed_at)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end
end
