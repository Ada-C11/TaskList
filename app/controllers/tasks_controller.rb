# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all.sort_by(&:id)
    @urgent_task = @tasks.min_by(&:completion_date)
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
    @task.is_complete = false
    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    redirect_to tasks_path if @task.nil?
  end

  def update
    task_id = params[:id]
    task = Task.find(task_id)

    task.update(task_params)
    redirect_to task_path(task.id)
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

  def toggle
    task_id = params[:id]
    task = Task.find(task_id)
    if task.is_complete
      task.update(
        is_complete: !task.is_complete
      )
    else # only updated when incomplete => complete
      task.update(
        is_complete: !task.is_complete,
        completion_date: DateTime.now
      )
    end
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(
      :name,
      :description,
      :completion_date
    )
  end
end
