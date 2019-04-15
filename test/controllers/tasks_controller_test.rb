# frozen_string_literal: true

require "test_helper"

describe TasksController do
  let (:task) do
    Task.create name: "sample task", description: "this is an example for a test",
                completion: Time.now + 5.days
  end

  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  # Unskip these tests for Wave 2
  describe "show" do
    it "can get a valid task" do
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do

      # Arrange
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion: "2019-04-27",
        },
      }

      # Act-Assert
      expect do
        post tasks_path, params: task_hash
      end.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion.strftime("%Y-%m-%d")).must_equal task_hash[:task][:completion]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # Your code here
      get edit_task_path(task)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Your code here
      get edit_task_path(-1)

      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    it "can update an existing task" do
      # Your code here
      task = Task.create!(name: "Drop classmates")
      task_hash = {
        task: {
          name: "go to the gym",
        },
      }
      patch task_path(task), params: task_hash

      must_respond_with :redirect
      must_redirect_to task_path(task)

      task.reload
      expect(task.name).must_equal(task_hash[:task][:name])
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      get task_path(-1)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "removes task from the database" do
      task = Task.create!(name: "Feed Chewy")

      expect do
        delete task_path(task)
      end.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path

      task_2 = Task.find_by(id: task_2)
      expect(task_2).must_be_nil
    end

    it "returns a 404 if the task does not exist" do
      task_3 = 500

      expect(Task.find_by(id: task_3)).must_be_nil

      expect do
        delete task_path(task_3)
      end.wont_change "Task.count"

      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
