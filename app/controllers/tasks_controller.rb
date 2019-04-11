class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if !@task
      redirect_to tasks_path, flash: { error: "Could not find task with id: #{task_id}" }
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
    )

    task.save

    redirect_to tasks_path, flash: { alert: "Task added successfully" }
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])

    # "task"=>{"name"=>"Feed bird again", "description"=>"Pellets and beans"}, "commit"=>"Save", "controller"=>"tasks", "action"=>"update", "id"=>"1"}

    task.update(name: params["task"]["name"], description: params["task"]["description"], completion_date: params["task"]["completion_date"], completed: params["task"]["completed"])

    redirect_to task_path(params[:id])
  end
end
