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
        binding.pry
        @task.title = params["task"]["title"],
        @task.description = params["task"]["description"]

        @task.save

        redirect_to tasks_path
    end
end


        


# #WAVE 2, Question 1
# def show
#     title_id = params[:id]
#     @title = TASKS[title_id]
#     if @title.nil?
#         head: not_found
#     end
# end

# #binding.pry - notes w/ Dan 
# unless params["title"]
#     render :new, status: bad_request
# end 

# @task = Task.find_by(id: title_id)

# class TasksController < ApplicationController
#     def index
#         @tasks = TASKS
#     end 
# end
