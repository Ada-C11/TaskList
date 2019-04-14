# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    redirect_to tasks_path unless @task
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.update(completed: false)

    redirect_to tasks_path
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
      return
    end
  end

  def update
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    unless task
      redirect_to tasks_path
      return
    end

    task.update(task_params)

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

  def toggle_complete
    task = Task.find_by(id: params[:id])

    unless task
      redirect_to tasks_path
      return
    end

    if task.completed
      task.completion_date = nil
      task.completed = false
      task.save
    else
      task.completion_date = Date.today
      task.update(completed: true)
    end

    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
