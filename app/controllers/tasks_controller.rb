
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
    @task = Task.new(name: params[:task][:name], description: params[:task][:description])
    if @task.save
      redirect_to task_path(@task.id), { :flash => { :success => "Successfully added task!" } }
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
    unless @task
      redirect_to task_path(@task.id), { :flash => { :error => "Could not find task with id: #{params[:id]}" } }
    end

    # binding.pry

    @task.name = params["task"]["name"]
    @task.description = params["task"]["description"]
    if @task.save
      redirect_to task_path(@task.id), { :flash => { :success => "Successfully updated task!" } }
    else
      redirect_to :edit, :flash => { :error => "Failed to update task" }
    end
  end
end
