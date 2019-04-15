class TasksController < ApplicationController

  # create tasklist hash

  TASKS = [
    {task_name: "complete tasks project", status: "Pending", done_by: "Today"},
    {task_name: "shower", status: "Pending", done_by: "Today"},
    {task_name: "call moma", status: "Pending", done_by: "Today"},

  ]

  def index
    @tasks = Task.all.order(:name)
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path :flash => {:error => "Task does not exist!"}
    end
  end

  def new
    @task = Task.new(name: "Type task here...")
  end

  def create
    task = Task.new(task_params)

    is_successful = task.save

    if is_successful
      redirect_to tasks_path
    else
      # For Rails Week 1, not a requirement (not possible right now?) to test this case in controller tests
      head :not_found
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path :flash => {:error => "Task does not exist!"}
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    if task
      is_successful = task.update(task_params)
      if is_successful
        redirect_to task_path(task.id)
      end
    else
      redirect_to root_path :flash => {:error => "The task was deleted!"}
    end
  end

  def toggle
    task = Task.find_by(id: params[:id])
    task.current_status?
    task.toggle(:current_status)
    task.save

    redirect_to tasks_path
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

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
