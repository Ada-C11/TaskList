class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to tasks_path
      return
    end

    if @task.completed
      @status = "completed"
    elsif @task.due_date && @task.due_date < DateTime.now
      @status = "overdue"
    else
      @status = "in-progress"
    end

    if @task[:completed]
      @change = "Incomplete"
    else
      @change = "Complete"
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    is_successful = task.save

    if is_successful
      redirect_to task_path(task.id)
    else
      head :not_found # refactor this?
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end

  def update
    task = Task.find_by(id: params[:id])

    if task.nil?
      redirect_to tasks_path
      return
    end

    is_successful = task.update(task_params)

    if is_successful
      redirect_to tasks_path
    else
      head :not_found
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found # refactor
    else
      task.destroy
      redirect_to tasks_path
    end
  end

  def mark_complete
    task = Task.find_by(id: params[:id])

    if task.completed
      cd = nil
    else
      cd = DateTime.now
    end

    if task.nil?
      head :not_found # refactor ?
    else
      task.update(completed: !(task[:completed]), completion_date: cd)
      redirect_to tasks_path
    end
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :due_date)
  end
end
