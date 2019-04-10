class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      head :not_found
    end
  end

  def new
    @task = Task.new 
    @task.task_name = "Default task name"
  end

  def create
    new_task = Task.new(
      task_name: params["task"]["task_name"],
      description: params["task"]["description"],
      completion_date: params["task"]["completion_date"]   
    )

    created_successfully = new_task.save 

    if created_successfully
      redirect_to task_path(new_task.id)
    else 
      head :not_found
    end
  end 

end
