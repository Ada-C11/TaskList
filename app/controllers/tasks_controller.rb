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
    task.update(task_params)
    redirect_to task_path(task)
  end

  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task
      @task.destroy
      redirect_to tasks_path
    else
      render :notfound, status: :not_found
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :completion_date)
  end
end
