class TasksController < ApplicationController
  def index # Loads a list of all the tasks
    @tasks = Task.all

    @urgent_task = @tasks.last

  end

  def show # shows the details of each task
    task_id = params[:id]
    puts "Task ID was #{task_id}"
    puts "Result of .to_i: #{task_id.to_i}"

    @task = Task.find_by(id: task_id)
    unless @task
      head :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completion_date: params[:task][:completion_date]
      )

    if @task.save # save returns true if the database insert succeeds
      redirect_to root_path # go to the index so we can see the task in the list
    else # save failed :(
      render :new # show the new task form view again
    end

    unless params["task"]
      render :new, status: :bad_request
      return
    end

    @task.name = params["task"]["name"],
    @task.description = params["task"]["description"]
    @task.completion_date = params["task"]["completion_date"]

    @task.save

    redirect_to tasks_path
  end

end
