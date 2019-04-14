# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    id = params[:id].to_i
    @task = Task.find_by(id: id)

    render :notfound, status: :not_found if @task.nil?
  end

  def new
    @task = Task.new(name: "-No Task Name-",
                     description: "-No Description-",
                     completion: "-No Completion Date-")
  end

  def create
    @Task.new(
      name: params[:task][:name],
      description: params[:task][:description],
      completion_date: params[:task][:completion],
    )
    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id].to_i)
  end

  def update
    @task = Task.find_by(id: params[:id].to_i)
    if @task.update(
      name: params[:task][:name],
      description: params[:task][:description],
      completion_date: params[:task][:completion],
    )
      redirect_to task_path
    else
      render :find_by
    end
  end
end
