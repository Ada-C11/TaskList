require "test_helper"

describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test", completed: false
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
          due_date: DateTime.parse("2019-05-01"),
          completed: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.due_date).must_equal task_hash[:task][:due_date]
      expect(new_task.completed).must_equal task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  describe "edit" do
    let (:task) {
      Task.create name: "sample task", description: "this is an example for a test", completed: false
    }

    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      invalid_task_id = -1
      get edit_task_path(invalid_task_id)
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    it "can update an existing task" do
      existing_task = Task.create(
        name: "Cook dinner",
        description: "Cooking dinner for four",
        due_date: DateTime.parse("2019-05-27"),
        completed: false,
      )

      task_hash = {
        task: {
          name: "Cook lunch",
        },
      }

      expect {
        patch task_path(existing_task.id), params: task_hash
      }.must_change "Task.count", 0

      must_respond_with :found
    end

    it "will redirect to the root page if given an invalid id" do
      invalid_task_id = -1
      patch task_path(invalid_task_id)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "destroy" do
    it "returns a 404 if the task is not found" do
      invalid_id = -1
      expect {
        delete task_path(invalid_id)
      }.must_change "Task.count", 0

      must_respond_with :not_found
    end

    it "can delete a task" do
      new_task = Task.create(
        name: "Feed dogs",
        description: "Feed dogs with Costco chicken and lamb",
        completed: false,
      )

      expect {
        delete task_path(new_task.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "can update existing status" do
      existing_task = Task.create(
        name: "Cook dinner",
        description: "Cooking dinner for four",
        due_date: DateTime.parse("2019-05-15"),
        completed: false,
      )

      expect {
        patch mark_complete_path(existing_task.id)
      }.must_change "Task.count", 0

      must_respond_with :found
    end
  end
end
