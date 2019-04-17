# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create task_params
    redirect_to task_path(@task)
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update task_params
    if !@task
      redirect_to task_path(@task.id), flash:
      { error: "Could not find task with id: #{params[:id]}" }
    else
      redirect_to task_path(@task)
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to root_path
  end

  def complete
    @task = Task.find(params[:id])
    if @task.completed_at.nil?
      @task.update_attribute(:completed_at, Time.now)
      redirect_to root_path
    else
      @task.update_attribute(:completed_at, nil)
  end
end

  private

  def task_params
    params.require(:task).permit(:title, :completed_at, :description)
  end
end
