class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
    if !@task
      redirect_to tasks_path(@task), :flash => { :error => "Could not find task with id: #{params[:id]}" }
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new task_params
    if @task.save
      redirect_to task_path(@task.id), { :flash => { :success => "Successfully added a task! Look at you, Busy Bee!" } }
    else
      redirect_to :new, :flash => { :error => "Failed to add task" }
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if !@task
      redirect_to tasks_path, :flash => { :error => "Could not find task with id: #{params[:id]}" }
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task
      if @task.update task_params
        redirect_to task_path(@task.id), { :flash => { :success => "Successfully updated task!" } }
      else
        redirect_to :edit, :flash => { :error => "Failed to update task" }
      end
    else
      redirect_to root_path, status: 302, :flash => { :error => "Could not find task with id: #{params[:id]}" }
    end
  end

  def destroy
  end
end
