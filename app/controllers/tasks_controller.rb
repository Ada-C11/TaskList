class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)

    unless @task
      head :not_found
    end

    def new
      @task = Task.new
    end

    def create
      puts "New task created!"

      @task = Task.new

      unless params["task"]
        render :new, status: :bad_request
        return
      end

      @task.name = params["task"]["name"],
                   @task.completion_date = params["task"]["completion_date"],
      @task.description = params["task"]["description"]

      @task.save

      redirect_to tasks_path
    end
  end
end
