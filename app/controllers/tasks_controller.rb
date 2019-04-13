class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
      return
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

    unless @task
      redirect_to tasks_path
      return
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    unless task
      redirect_to tasks_path
      return
    end

    task.update(task_params)

    redirect_to tasks_path
  end

  def destroy
    task = Task.find_by(id: params[:id])

    unless task
      head :not_found
      return
    end

    task.destroy

    redirect_to tasks_path
  end

  def toggle_complete
    task = Task.find_by(id: params[:id])

    unless task
      head :not_found
      return
    end

    task.completion_date = DateTime.current
    task.save

    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description)
  end
end
