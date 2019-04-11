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
    @task.name = "Name of task goes here"
  end

  def create
    form_data = params["task"]
    name = form_data["name"]
    description = form_data["description"]
    if form_data["completed"] == nil
      completed = false
    else
      completed = form_data["completed"]
    end

    @task = Task.new(name: name, description: description, completed: completed )
    if @task.save 
      redirect_to tasks_path
    else
      head :redirect
    end
  end

end
