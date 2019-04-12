require "test_helper"

describe TasksController do
  before do 
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: 'July 13 2019'
  }

  describe "index" do
    it "can get the index path" do
      get tasks_path

      must_respond_with :success
    end

    it "can get the root path" do
      get root_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid task" do
      get task_path(task.id)

      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      get task_path(-1)

      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do

      get new_task_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do

      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: 'false',
        },
      }

       expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do

      get edit_task_path(task)

      must_respond_with :success

    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      task = 

      get edit_task_path(task)

      must_respond_with :success

    end
  end

  describe "update" do
    it "can update an existing task" do
            task = Task.create!(name: "Do dishes")
      task_data = {
        task: {
          name: "Dont do dishes",
        },
      }

      # Act
      patch task_path(task), params: task_data

      # Assert
      must_respond_with :redirect
      must_redirect_to task_path(task)

      task.reload
      expect(task.name).must_equal(task_data[:task][:name])
    end


    it "will redirect to the root page if given an invalid id" do
      skip
      # Your code here
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here

    #Arrange
    
    #Act

    #Assert



  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here

    #Arrange
    
    #Act

    #Assert

  end
end