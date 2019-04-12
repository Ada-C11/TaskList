# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @urgent_task = @tasks.min_by { |task| Date.parse(task.completion_date).to_time.to_i }
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
    @task = Task.new(book_params)
    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new
    end
  end

  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
  end

  def update
    task_id = params[:id]
    task = Task.find(task_id)

    task.update(book_params)
    redirect_to task_path(task.id)
  end

  def destroy
    task_id = params[:id]
    task = Task.find_by(id: task_id)

    # if task
    #   task.destroy
    # end
    task&.destroy
    redirect_to tasks_path
  end

  def toggle
    task_id = params[:id]
    task = Task.find(task_id)
    task.update(
      is_complete: !task.is_complete
    )
    redirect_to tasks_path
  end

  private

  def book_params
    params.require(:task).permit(
      :name,
      :description,
      :completion_date
      # :is_complete
    )
  end
end
