class TasksController < ApplicationController
    def root
        @message = "Hi there!"
    end 

    def show
        @task = Task.find(params['id'])
    end

    def index
        @tasks = Task.all 
    end

    def new
        @new = Task.new
    end

    def create
        @task = Task.new

        unless params["task"]
            render :new, status: :bad_request
            return
        end

        @task.title = params["task"]["title"],
        @task.description = params["task"]["description"]

        @task.save
        redirect_to tasks_path
    end

    def show
        task_id = params[:id]
        @task = Task.find_by(id: task_id)
   
        redirect_to tasks_path if @task.nil?
    end

    def edit
        task_id = params[:id]
        @task = Task.find_by(id: task_id)
    
        redirect_to tasks_path if @task.nil?
    end
    
    # def.update(
    #     @task = Task.find(params[:id])
    
    #     unless task
    #       redirect_to tasks_path
    #       return
    #     end
    #     task.update(task_params)
    #     redirect_to task_path(task)
    # end

        #from wave 4 test #1- done in class 
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

    def toggle_complete
        task_id = params[:id]
        task = Task.find_by(id: task_id)
    
        unless task
          head :not_found
          return
        end
    
        if task.completion_date.nil?
          task.update!(completion_date: Date.current)
        else
          task.update!(completion_date: nil)
        end
    
        redirect_to tasks_path
    end

    private
    def task_params
        return params.require(:task).permit(:task, :description)
    end
end



        
