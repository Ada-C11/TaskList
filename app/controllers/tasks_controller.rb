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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update task_params
    redirect_to task_path(@task)
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
