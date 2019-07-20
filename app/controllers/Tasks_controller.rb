class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:name)
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to action: "index"
    end
  end

  def new
    @task = Task.new(complete: false, complete_date: nil)
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
      complete: params["task"]["complete"],
      complete_date: params["task"]["complete_date"],
    )

    is_successful = task.save

    if is_successful
      redirect_to tasks_path
    else
      head :not_found
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to action: "index"
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    if task.nil?
      redirect_to action: "index"
    elsif task.update(task_params)
      redirect_to task_path(task.id)
    else
      redirect_to action: "index"
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
    task = Task.find_by(id: params[:id])
    task.toggle(:complete)

    if task.nil?
      redirect_to tasks_path
    elsif task.complete == true
      task.update(complete_date: Date.current)
    elsif task.complete == false
      task.update(complete_date: nil)
    end
    redirect_back fallback_location: task_path(task.id)
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :complete, :complete_date)
  end
end
