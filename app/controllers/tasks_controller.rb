class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:completion_date).reverse_order
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    unless @task
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
    end
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
    unless @task
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
    end
  end

  def update
    task_id = params[:id]
    curr_task = Task.find_by(id: task_id)
    if curr_task
      curr_task.update(task_params)
    else
      flash[:error] = "Could not find task with id: #{task_id}"
    end
    redirect_to root_path
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id: task_id)
    task.destroy if task
    redirect_to root_path
  end

  def mark
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task
      @task.completion_date = (@task.completion_date ? nil : DateTime.current)
      @task.save
    else
      flash[:error] = "Could not find task with id: #{task_id}"
    end
    redirect_to task_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :priority_level, :completion_date, :description)
  end
end
