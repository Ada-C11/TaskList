
class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        task = Task.new(task_params)

        unless params["task"]
            render :new, status: :bad_request
            return
        end
        
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

    def completed
        task_id = params[:id]

        task = Task.find_by(id: task_id)

       unless task
        head :not_found
        return
       end

        task.toggle(:completed)
        task.update_attribute(:completiondate, Time.now)
        task.save
        task.reload

       redirect_to tasks_path
    end

    private

    def task_params
        return params.require(:task).permit(:title, :content, :completiondate, :completed)
    end
end