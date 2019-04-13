class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to "tasks_path"
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :not_found
    end
  end

  def edit
    # @task = Task.find(params[:id])
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to :root
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update(task_params)

    if @task
      redirect_to task_path(@task)
    else
      redirect_to :root
    end
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

  def complete
    task = Task.find_by(id: params[:id])
    
    unless task
      head :not_found
      return
    end

    task.completed = !task.completed

    if task.completed
      task.date_completed = Date.today
    else
      task.date_completed = nil
    end

    task.save
    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :due_date)
  end
end
