class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to tasks_path
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id) 
    redirect_to tasks_path unless @task
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id: task_id)
  
    if task
      task.destroy
      redirect_to tasks_path
    else
      render :notfound, status: :not_found
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path unless @task
  end

  def update
    task = Task.find(params[:id])
    
    unless params["task"]
      render :new, status: :bad_request
      return
    end

    task.update(task_params)
    redirect_to tasks_path
  end

  def toggle
    @task = Task.find(params[:id])

    @task.update_attribute(:completed_at, Time.now)
    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion, :completed_at)
  end
end
