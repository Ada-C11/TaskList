class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to task_path
    end
  end

  def new
    @task = Task.new(name: "name")
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
    )

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :not_found
    end
  end
end
