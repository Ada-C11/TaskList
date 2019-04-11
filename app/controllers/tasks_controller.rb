class TasksController < ApplicationController

  def index
    @tasks = Task.all.order(:id)
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
    end
  end

  def new
    @task = Task.new
    @task.name = "Name of task goes here"
  end

  def create
    form_data = params["task"]
    name = form_data["name"]
    description = form_data["description"]
    completion_date = form_data["completion_date"]
   

    @task = Task.new(name: name, description: description, completion_date: completion_date, completed: false)
    if @task.save 
      redirect_to task_path(@task.id)
    else
      head :not_found
    end
  end

  def edit
    @edited_task = Task.find_by(id: params[:id])
    if @edited_task.nil?
      redirect_to tasks_path
    end
  end

  def update
    form_data = params["task"]
    edit_name = form_data["name"]
    edit_description = form_data["description"]
    edit_completion_date = form_data["completion_date"]
    
    @edited_task = Task.find_by(id: params[:id])
    if !edit_name.nil?
      @edited_task.name = edit_name
    end
    if !edit_description.nil?
      @edited_task.description = edit_description
    end
    if !edit_completion_date.nil?
      @edited_task.completion_date = edit_completion_date
    end

    if @edited_task.save 
      redirect_to task_path(@edited_task.id)
    else
      head :not_found
    end
  end

end
