class TasksController < ApplicationController
  # TASKS = [
    # {name: "Call Ma", description: "Family First", completed_at: "", completion_date: ""}
  # ]

  def index    
    @tasks = Task.all.order(:created_at)
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to task_path
    end
  end

  def new
    @task = Task.new(name: "Default Name")
  end

  def create
    task = Task.new(task_params)

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :not_found #should be a server error instead 
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
    end
  end
 
  def update
    task = Task.find_by(id: params[:id])

    if task.nil?
      redirect_to tasks_path
    else
      is_successful = task.update(task_params)
    end

    if is_successful
      redirect_to task_path(task.id)
    end
  end

  def toggle_complete
    task = Task.find_by(id: params[:id])

    if task.completed_at == "Incomplete"
      task.completed_at = "Complete"
      task.completion_date = Time.now.strftime("%F %T")
      task.update(completed_at: task.completed_at)
      redirect_to tasks_path
    elsif task.completed_at == "Complete"
      task.completed_at = "Incomplete"
      task.update(completed_at: task.completed_at)
      redirect_to tasks_path
    else
      task.completed_at = "Complete"
      task.completion_date = Time.now.strftime("%F %T")
      task.update(completed_at: task.completed_at)
      redirect_to tasks_path
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

  def verify
    @task = Task.find_by(id: params[:id])
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed_at, :completion_date)
  end
  
end
