


class TasksController < ApplicationController

    def index
        @tasks = Task.all
     
    end

    def show
    task_id = params[:id]
    puts "Task ID was #{task_id}"
    puts "result of .to_i: #{task_id.to_i}"
    @task = Task.find_by(id: task_id)

    unless @task
        #head :not_found
        redirect_to tasks_path
    end
    end
    def new
        @task = Task.new
    
    end
    def create
        @task = Task.new
        unless params["task"]
            render :new, status: :bad_request
            return
        end

        @task.name = params["task"]["name"]
        @task.description = params["task"]["description"]
        @task.save
        redirect_to task_path(@task.id)
    end
    def edit
        @task = Task.find(params[:id])

    end
    def update
        @task = Task.find(params[:id])
        @task.update(name: params["task"]["name"], description: params["task"]["description"], completion_date: params["task"]["completion_date"])
        redirect_to task_path 
    end

    


end
