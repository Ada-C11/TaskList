class TasksController < ApplicationController
  TASKS = [
    { name: "cleaning", description: "vacuum" },
    { name: "dinner", description: "make soup" },
    { name: "shopping", description: "Go to Target" },
  ]

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    # puts params

    if @task.nil?
      redirect_to root_path
    end
  end

  def new
    @task = Task.new(name: "Default task")
  end

  def create
    # puts params
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

  def edit
    puts params
    task_id = params[:id]

    @task = Task.find_by(id: task_id)
  end

  #   def destroy
  #     task = Task.find_by(id: params[:id])

  #     if task.nil?
  #   head: not_found
  # else
  #     task.destroy
  #     redirect_to tasks_path
  #   end
  # end
end
