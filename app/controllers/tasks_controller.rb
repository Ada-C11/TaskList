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
  end

  def create
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completed: params[:task][:completed],
    )

    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new
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
    task_to_update = Task.find_by(id: task_id)

    edited_name = params[:task][:name]
    edited_description = params[:task][:description]
    edited_completed = params[:task][:completed]

    task_to_update.name = edited_name
    task_to_update.description = edited_description
    task_to_update.completed = edited_completed

    if task_to_update.save
      redirect_to task_path(task_id)
    end
  end

  def destroy
    task_to_destroy = Task.find(params[:id])

    if task_to_destroy.nil?
      head :not_found
    else
      task_to_destroy.destroy
      redirect_to tasks_path
    end
  end
end
