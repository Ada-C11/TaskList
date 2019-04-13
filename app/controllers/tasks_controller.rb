class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to root_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    is_sucessful = task.save

    if is_sucessful
      redirect_to task_path(task.id)
    else
      head :not_found
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    if !task.nil?
      task.update(task_params)
      redirect_to task_path(task.id)
    else
      redirect_to root_path
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])
    if !task.completed
      task.update(
        completed_date: DateTime.now,
        completed: true,
      )
    else
      task.update(
        completed_date: nil,
        completed: false,
      )
    end
    
    redirect_to root_path
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
    else
      task.destroy
      redirect_to root_path
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :due_date, :completed, :completed_date)
  end
end
