# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    redirect_to task_path(@task)
  end

  def show
    @task = Task.find_by(id: params[:id])
    if !@task
      redirect_to tasks_path, flash:
      { error: "Could not find task with id: #{params[:id]}" }
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    if !@task
      redirect_to tasks_path, flash:
      { error: "Could not find task with id: #{params[:id]}" }
    else
      @task.update task_params

      redirect_to task_path(@task)
    end
  end

  def destroy
    begin
      Task.find(params[:id]).destroy
      redirect_to root_path
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def complete
    @task = Task.find(params[:id])
    if @task.completed_at.nil?
      @task.update_attribute(:completed_at, Time.now)
      @task.update_attribute(:completed, true)
    else
      @task.update_attribute(:completed_at, 'nil')
      @task.update_attribute(:completed, false)
    end
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
