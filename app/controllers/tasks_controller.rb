class TasksController < ApplicationController
  # TASKS = [
  #   { task: "Laundry", date: "04-5-18" },
  #   { task: "Meal Prep", date: "04-5-19" },
  # ]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    # @task.name = "default title"
    # @task.save
  end

  def create
    # task = Task.new
    @task = Task.new
    unless params["task"]
      render :new, status: :bad_request
      return
    end

    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    if params[:task][:date]
      @task.date = Date.parse(params[:task][:date])
    end
    # task = Task.new(
    #   name: params[:task][:name],
    #   description: params[:task][:description],
    #   date: Date.parse(params[:task][:date]),
    # )

    @task.save

    redirect_to task_path(@task.id)
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)
    unless @task
      redirect_to tasks_path
      return
    end

    head :not_found unless @task
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end
end
