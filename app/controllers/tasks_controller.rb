class TasksController < ApplicationController

  def index
    @tasks = Task.all.order(:id)
  end

  def show 
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def new 
    @task = Task.new(task: "I have to ")
  end

  def create 
    new_task = Task.new(task_params)

    is_successful = new_task.save

    if is_successful
      redirect_to task_path(new_task.id)
    else
      head :not_found
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    existing_task = Task.find_by(id: params[:id])

    # is_successful = existing_task.update(task_params)

    if existing_task && existing_task.update(task_params)
      redirect_to task_path(existing_task.id)
    else
      redirect_to tasks_path
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])

    task.toggle(:completed)
    task.save
    task.touch

    # redirect_to tasks_path
    redirect_back(fallback_location: tasks_path)
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


  private

  def task_params
    return params.require(:task).permit(:task, :descriptions, :completed)
  end
end
