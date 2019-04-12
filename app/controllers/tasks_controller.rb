# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params['task']['name'],
      description: params['task']['description'],
      completion_date: params['task']['completion_date']
    )

    task.save

    redirect_to tasks_path
  end

  def show
    task_id = params[:id]

    puts "Task ID was #{task_id}"

    @task = Task.find_by(id: task_id)

    unless @task
      # head :not_found
      redirect_to tasks_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    redirect_to tasks_path unless @task
  end

  def update
    @task = Task.find(params[:id])
    @task.update(
      name: params['task']['name'],
      description: params['task']['description'],
      completion_date: params['task']['completion_date']
    )
    redirect_to task_path(@task)
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
end
