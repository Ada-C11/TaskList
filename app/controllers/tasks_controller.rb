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
    task = Task.new

    task.name = params["task"]["name"]
    task.description = params["task"]["description"]
    task.completion_date = params["task"]["completion_date"]

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
    @task.update(book_params)
    
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

  private
  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end