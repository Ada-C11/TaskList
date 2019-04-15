# frozen_string_literal: true

require 'pry'
class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    task.save

    redirect_to tasks_path
  end

  def show
    task_id = params[:id]

    @task = Task.find_by(id: task_id)

    redirect_to tasks_path unless @task
  end

  def edit
    @task = Task.find_by(id: params[:id])

    redirect_to tasks_path unless @task
  end

  def update
    task = Task.find_by(id: params[:id])

    unless task
      redirect_to root_path
      return
    end

    task.update(task_params)

    redirect_to task_path(task)

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

  def complete
    task_id = params[:id]

    task = Task.find_by(id: task_id)

    unless task
      head :not_found
      return
    end

    task.completed = !task.completed

    task.save

    redirect_to root_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
