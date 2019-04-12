class TasksController < ApplicationController
  def index
    @tasks = Task.all
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
    @task.task_name = "Default task name"
    @task.completed = "true/false"
  end

  def create
    new_task = Task.new(
      task_name: params["task"]["task_name"],
      description: params["task"]["description"],
      completed: params["task"]["completed"],
    )

    created_successfully = new_task.save

    if created_successfully
      redirect_to task_path(new_task.id)
    else
      head :not_found
    end
  end

  def edit
    task_id = params[:id].to_i
    @task_to_edit = Task.find_by(id: task_id)
    if @task_to_edit.nil?
      redirect_to tasks_path
    end
  end

  def update
    task_id = params[:id].to_i
    task_to_update = Task.find(task_id)

    new_completed = params["task"]["completed"]
    new_description = params["task"]["description"]
    new_name = params["task"]["task_name"]

    task_to_update.task_name = new_name
    task_to_update.description = new_description
    task_to_update.completed = new_completed

    updated_successfully = task_to_update.save

    if updated_successfully
      redirect_to task_path(task_id)
    else
      redirect_to tasks_path
    end
  end

  def destroy
    task_to_destroy = Task.find_by(id: params[:id]) #find_by gives nil if not found

    if task_to_destroy.nil?
      head :not_found
    else
      task_to_destroy.destroy
      redirect_to tasks_path
    end
  end
end
