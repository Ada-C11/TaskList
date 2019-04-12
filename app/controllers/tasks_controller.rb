TASKS = ["walk the dog", "make a bank deposit", "get groceries and stuff"]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
      completion_date: params["task"]["completion_date"],
    )

    task.save

    redirect_to task_path(task.id)
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path, status: 301
    end
  end

  def edit
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    redirect_to tasks_path if @task.nil?
  end

  def update
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    puts "***** #{params}"
    @task.update(
      name: params["task"]["name"],
      description: params["task"]["description"],
      completion_date: params["task"]["completion_date"],
    )
    redirect_to task_path(@task)
  end
end
