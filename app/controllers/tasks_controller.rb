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
    @task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completion: params[:task][:completion],
    )
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
    @task = Task.find_by(id: params[:id].to_i)
    if @task.update(
      name: params[:task][:name],
      description: params[:task][:description],
      completion: params[:task][:completion],
    )
      redirect_to task_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id].to_i)
    if @task.destroy
      redirect_to task_path
    else
      render :find_by
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.completion_date = Date.today
    @task.save

    redirect_to tasks_path
  end

  def task_params
    return params.require(:task).permit(
             :name,
             :description,
             :completion
           )
  end
end
