
class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        task = Task.new

        unless params["task"]
            render :new, status: :bad_request
            return
        end

        
        task.title = params["task"]["title"]
        task.content = params["task"]["content"]
        task.completiondate = params["task"]["completiondate"]
        
        task.save
        
        redirect_to task_path(task.id)
    end

    def show
        task_id = params[:id]
        @task = Task.find_by(id: task_id)

        if @task.nil?
            redirect_to tasks_path
        end
    end

    def edit
        task_id = params[:id]
        @task = Task.find_by(id: task_id)

        if @task.nil?
            redirect_to tasks_path
        end
    end

    def update
        task_id = params[:id]
        task = Task.find_by(id: task_id)

        if task.nil?
            redirect_to tasks_path
            return
        end

        task.update_attributes(params[:task].permit(:title, :content, :completiondate))

        redirect_to task_path(task.id)
    end
end