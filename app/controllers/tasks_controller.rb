class TasksController < ApplicationController
  TASKS = [
    "get groceries", "go clothing shopping", "walk the dog"    
  ]
  
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
    @task = Task.new(title: "Default Title")
  end

end
