require "test_helper"
require "pry"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed: false
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
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed).must_equal task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # successfully goes to edit page
      # Arrange

      # Act
      get edit_task_path(task)
      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # successfully rediredts
      # Arrange
      # Act
      get edit_task_path(3456)
      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    it "can update an existing task" do
      task_data = {
        task: {
          name: "changed sample task",
        },
      }

      patch task_path(task), params: task_data
      task.reload
      expect(task.name).must_equal(task_data[:task][:name])
    end

    it "will redirect to the root page if given an invalid id" do
      task_data = {
        task: {
          name: "changed sample task",
        },
      }

      patch task_path(1234), params: task_data

      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "removes the task from the database" do
      task

      expect {
        delete task_path(task)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end

    it "returns a 404 if the task does not exist" do
      # Arrange
      task_id = 123456

      # Assumptions
      expect(Task.find_by(id: task_id)).must_be_nil

      # Act
      expect {
        delete task_path(task_id)
      }.wont_change "Task.count"

      # Assert
      must_respond_with :redirect
    end
  end

  # Complete for Wave 4
  describe "complete_toggle" do
    it "redirects in attempt to mark nonexistent task" do
      patch complete_task_path(3456)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "marks a task complete" do
      expect(task.completion_date).must_be_nil
      expect(task.completed).must_equal false
      patch complete_task_path(task)

      task.reload

      # used delta = 1 because updated date and completed date might have some lag
      assert_in_delta(task.updated_at, task.completion_date, delta = 1)
      expect(task.completed).must_equal true
    end

    it "unmarks a completed task" do
      date = Time.new(2019, 04, 01)
      completed_task = Task.create!(name: "completed sample task", description: "test completed task",
                                    completed: true, completion_date: date)

      expect(completed_task.completion_date).must_equal date
      expect(completed_task.completed).must_equal true

      patch complete_task_path(completed_task)
      completed_task.reload
      expect(completed_task.completion_date).must_be_nil
      expect(completed_task.completed).must_equal false
    end
  end
end
