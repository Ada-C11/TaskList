class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      # to pass the test. I'm wondering why it redirects instead of giving a 404 page.
      redirect_to tasks_path, :flash => { :error => "Task id: #{params[:id]} not found!" }
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params["task"]["name"],
      description: params["task"]["description"],
      completion_date: params["task"]["completion_date"],
    )

    is_successful = task.save
    if is_successful
      redirect_to task_path(task.id), :flash => { :success => "Task successfully created!" }
    else
      redirect_to task_path(task_id)
      # flash[:error] = "Cannot create task: #{params[:name]}"
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      # need to check again
      redirect_to tasks_path
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    if task.nil?
      redirect_to root_path
    end

    is_successful = task.update(task_params)
    if is_successful
      redirect_to task_path(task.id)
    else
      redirect_to tasks_path
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
    else
      task.destroy
      redirect_to tasks_path, :flash => { :success => "Task #{task.name} has been deleted!" }
    end
  end

  def toggle_complete
    task = Task.find_by(id: params[:id])

    if task
      if task.update task_params
        redirect_to root_path, :flash => { :success => "Task #{task.name} has been marked Complete" }
      else
        redirect_to root_path, :flash => { :error => "Failed to update task #{params[:name]}" }
      end
    else
      redirect_to root_path, :flash => { :error => "Could not find task #{params[:name]}" }
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
