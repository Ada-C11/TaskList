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
    @task = Task.new(name: "Location")
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      completion_date: params["task"]["completion_date"],
      description: params["task"]["description"]
      )

    # If the book saves correctly, then we want to redirect to the show page of that book
    # Otherwise, we should give back something about the error (for now, 404)

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      # For Rails Week 1, not a requirement (not possible right now?) to test this case in controller tests
      head :not_found
    end
  end

end
