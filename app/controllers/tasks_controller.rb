# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i

    @task = Task.find_by(id: id)
    unless @task
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.completion_status = false
    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new
    end
  end

  def edit
    id = params[:id]
    @task = Task.find_by(id: id)

    if @task.nil?
      redirect_to tasks_path
    end
  end

  def update
    id = params[:id]
    task = Task.find(id)

    task.update(task_params)
    redirect_to task_path(task.id)
  end

  def destroy
    id = params[:id]
    task = Task.find_by(id: id)

    unless @task
      head :not_found
      return
    end

    task.destroy

    redirect_to tasks_path
  end

  def toggle
    id = params[:id]
    task = Task.find(id)
    if task.completion_status
      task.update(
        completion_status: !task.completion_status,
      )
    else
      task.update(
        completion_status: !task.completion_status,
        completion: Time.now,
      )
    end
    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(
             :name,
             :description,
             :completion
           )
  end
end
