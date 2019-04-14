require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                date: Time.now + 5.days
  }

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
      must_respond_with :ok
    end
  end

  describe "create" do
    it "can create a new task" do

      # Arrange
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          date: Date.new(2019, 4, 20),
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.date).must_equal task_hash[:task][:date]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_task_path(task)

      # Assert
      must_respond_with :ok
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  describe "update" do
    it "can update an existing task" do
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          date: Date.new(2019, 4, 20),
        },
      }

      patch task_path(task), params: task_hash

      new_task = Task.find_by(id: task.id)

      expect(new_task.name).must_equal task_hash[:task][:name]
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.date).must_equal task_hash[:task][:date]

      must_respond_with :redirect
      must_redirect_to task_path(task)
    end

    it "will redirect to the root page if given an invalid id" do
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          date: Date.new(2019, 4, 20),
        },
      }
      patch task_path(123456), params: task_hash

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "removes the book from the database" do
      task = Task.first

      expect {
        delete task_path(task)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path

      destroyed_task = Task.find_by(id: task.id)
      expect(destroyed_task).must_be_nil
    end

    it "returns a 404 if the book does not exist" do
      task_id = 1337432

      expect(Task.find_by(id: task_id)).must_be_nil

      expect {
        delete task_path(task_id)
      }.wont_change "Task.count"

      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "Will change complete to true if false" do
      new_task = Task.new(complete: false)
      new_task.save

      new_task = Task.find(new_task.id)
      expect(new_task.complete).must_equal false

      put task_path(new_task.id)

      new_task = Task.find(new_task.id)
      expect(new_task.complete).must_equal true
    end

    it "Will change complete to false if true" do
      completed_task = Task.new(complete: true)
      completed_task.save

      expect(completed_task.complete).must_equal true

      put task_path(completed_task.id)
      completed_task.save

      completed_task = Task.find(completed_task.id)
      expect(completed_task.complete).must_equal false
    end

    it "returns a 404 if the book does not exist" do
      task_id = 1337532

      expect(Task.find_by(id: task_id)).must_be_nil

      put task_path(task_id)

      must_respond_with :not_found
    end
  end
end
