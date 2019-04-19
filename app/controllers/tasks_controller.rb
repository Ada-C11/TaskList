class TasksController < ApplicationController

  # THE DECENDING ORDER SORT ON DATE_DUE IS NOT WORKING IN RAILS CONSOLE; DOES WORK IN THE BROWSER

  def index
    @tasks = Task.all.order(date_due: :asc)
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new(task_name: "to-do")
  end

  def create
    this_task = Task.new(task_params)
    is_successful = this_task.save

    if is_successful
      redirect_to tasks_path
    else
      head :not_found
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    unless @task
      redirect_to tasks_path
    end
  end

  def update
    this_task = Task.find_by(id: params[:id])

    is_successful = this_task.update(task_params)

    if is_successful
      redirect_to task_path
    else
      redirect_to tasks_path
    end
  end

  def destroy
    this_task = Task.find_by(id: params[:id])

    is_successful = this_task.destroy

    if is_successful
      redirect_to tasks_path
    else
      head :not_found
    end
  end

  def toggle_completed
    this_task = Task.find_by(id: params[:id])
    # raise
    # this_task.toggle(:completed)
    # this_task[:date_completed] = Time.now
    # this_task.save

    if this_task.completed == true
      this_task.completed = false
      this_task[:date_completed] = nil
    elsif this_task.completed == false
      this_task.completed = true
      this_task[:date_completed] = Time.now
    end

    this_task.save

    redirect_to tasks_path
  end

  private

  def task_params
    # Responsible for returning strong params as Rails wants it
    # Tells Rails that we want params to look like this nested hash, and only this nested hash
    # {
    #   book: {
    #     author: "some author",
    #     title: "some title",
    #     description: "description"
    #   }
    # }
    return params.require(:task).permit(:task_name, :description, :date_due, :date_completed, :completed)
  end
end
