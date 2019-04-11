# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
    end
  end

  def new
    @new_task = Task.new
  end

  def create
    @task = Task.new

    unless params['task']
      render :new, status: :bad_request
      return
    end

    @task.name = params['task']['name']
    @task.description = params['task']['description']
    @task.save

    redirect_to tasks_path
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
    end

  end

  def update
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    unless task
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to tasks_path
    end

    task.name = params['task']['name']
    task.description = params['task']['description']
    task.save

    redirect_to task_path(task_id)
  end

  def destroy
    task_id = params[:id]

    task = Task.find_by(id: task_id)

    unless task
      head :not_found
      return
    end

    task.destroy

    redirect_to tasks_path
  end
end
