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
    # Change to strong params
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

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    # Change to strong params
    if @task.update(
      name: params["task"]["name"],
      completion_date: params["task"]["completion_date"],
      description: params["task"]["description"]
    )
      redirect_to tasks_path
    else
      head :not_acceptable
    end
  end

  def destroy
    task = Task.find_by(id:  params[:id] )

    if task.nil?
      head :not_found
    else
      task.destroy 
      redirect_to tasks_path
    end
  end

  def complete
    task = Task.find_by(id: params[:id])
    if task[:completed] == false
      task[:completed] = true
    else
      task[:completed] = false
    end
    task.save
    redirect_to tasks_path
  end

end
