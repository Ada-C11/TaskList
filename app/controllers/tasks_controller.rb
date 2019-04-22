class TasksController < ApplicationController
  TASKS = [
    { name: "cleaning", description: "vacuum" },
    { name: "dinner", description: "make soup" },
    { name: "shopping", description: "Go to Target" },
  ]

  def index
    @tasks = Task.all.order(:name)
  end

  def show
    @task = Task.find_by(id: params[:id])

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

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    task = Task.find_by(id: params["id"])
    # task.update(name: params["task"]["name"], description: params["task"]["description"])

    if task.nil?
      redirect_to tasks_path
    elsif task.update(task_params)
      redirect_to task_path(task.id)
    else
      redirect_to tasks_path
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
    else
      task.destroy
      redirect_to tasks_path
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])
    task.toggle(:completed)
    task.save
    task.touch

    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completed)
    #need to update def create if you want to use this.
    #only permitted params can be allowed, so make sure to include what you want
  end
end
