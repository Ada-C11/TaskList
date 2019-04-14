class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:completion_date).reverse_order
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    flash[:error] = "Could not find task with id: #{task_id}"
    redirect_to tasks_path unless @task
  end

  def new
    @task = Task.new
  end

  def create
    new_task = Task.new(task_params)
    #error handle when saving incase unsuccessful
    if new_task.save
      redirect_to task_path(new_task)
    else
      head :not_found
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    flash[:error] = "Could not find task with id: #{task_id}"
    redirect_to tasks_path unless @task
  end

  def update
    task_id = params[:id]
    curr_task = Task.find_by(id: task_id)
    if task_id
      curr_task.update(task_params)
    else
      head :not_found
    end
    redirect_to task_path(curr_task)
  end

  private

  def task_params
    return params.require(:task).permit(:name, :priority_level, :completion_date, :description)
  end
end
