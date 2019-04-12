class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @urgent_task = @tasks.min_by { |task| Date.parse(task.completion_date).to_time.to_i }
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    unless @task.nil?
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
      completion_date: params[:task][:completion_date]
    )
    if @task.save
      redirect_to task_path(@task.id)
    else
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)

    redirect_to task_path(task.id)
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

  def mark_complete
    @task = Task.find(params[:id])
    @task.completion_date = current_date
    @task.save
    redirect_to tasks_path
  end

  def task_params
    return params.require(:task).permit(
      :name,
      :description,
      :completion_date
    )
  end

end
