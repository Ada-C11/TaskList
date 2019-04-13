
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
    @task = Task.new

  end

  def create
    @task = Task.new(task_params) 
    @task.update(completed: false)
    if @task.save 
      redirect_to task_path(@task.id)
    else
      head :not_found
    end
  end

  def edit
    @edited_task = Task.find_by(id: params[:id])
    if @edited_task.nil?
      redirect_to tasks_path
    end
  end

  def update
    edited_task = Task.find_by(id: params[:id])
    if edited_task.nil?
      redirect_to tasks_path
    else
      is_successful = edited_task.update(task_params)
      if is_successful
        redirect_to task_path    
      else
        head :not_found      
      end
    end
  end

  def destroy
    delete_task = Task.find_by(id: params[:id])
    if delete_task.nil?
      head :not_found
    else
      delete_task.destroy
      redirect_to tasks_path
    end
  end

  def mark_done
    mark_task = Task.find_by(id: params[:id])
    if mark_task.nil?
      head :not_found
    else
      mark_task.toggle :completed 
      mark_task.update(completion_date: Date.today)
      redirect_to tasks_path
    end
  end
  
end

private

def task_params
  return params.require(:task).permit(:name, :description, :completed)
end

