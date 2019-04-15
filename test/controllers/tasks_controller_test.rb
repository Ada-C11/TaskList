require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed: false, due_date: DateTime.now
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
      invalid_task_id = -1
      # Act
      get task_path(invalid_task_id)

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
          due_date: DateTime.now,
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
    before do
      task_name = "new task"
      task_description = "new task description"
      task_completed = false

      # Act-Assert
      task = Task.new(
        name: task_name,
        description: task_description,
        completed: task_completed,
      )
    end

    it "can get the edit page for an existing task" do
      get edit_task_path(task.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      invalid_task_id = 999

      get edit_task_path(invalid_task_id)

      must_respond_with :redirect
      must_redirect_to tasks_path
      # Your code here
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.

    it "can update an existing task" do
      task2 = Task.create(name: "new task", description: "A thing", due_date: DateTime.now)

      update_hash = {
        task: {
          name: "updated task",
          description: "updated task description",
          completed: false,
          due_date: DateTime.now,
        },
      }

      expect(task2.name).must_equal "new task"

      expect {
        patch task_path(task2.id), params: update_hash
      }.must_change "Task.count", 0

      task2.reload

      expect(task2.name).must_equal update_hash[:task][:name]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "will redirect to the root page if given an invalid id" do
      invalid_task_id = 999

      patch task_path(invalid_task_id)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "can delete a task" do
      task1 = task

      expect {
        delete task_path(task1.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "404 if no task found" do
      invalid_task_id = 999

      delete task_path(invalid_task_id)

      must_respond_with :not_found
    end
  end

  describe "toggle_complete" do
    it "Can toggle from incomplete to complete" do
      task3 = Task.create(name: "new task", description: "A thing", due_date: DateTime.now)

      update_hash2 = {
        task: {
          completed: true,
        },
      }

      expect(task3.completed).must_equal false

      expect {
        patch mark_complete_path(task3.id), params: update_hash2
      }.must_change "Task.count", 0

      task3.reload

      expect(task3.completed).must_equal true

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "Can toggle from complete to incomplete" do
      task4 = Task.create(name: "new task", description: "A thing", due_date: DateTime.now, completed: true)

      update_hash3 = {
        task: {
          completed: false,
        },
      }

      expect(task4.completed).must_equal true

      expect {
        patch mark_complete_path(task4.id), params: update_hash3
      }.must_change "Task.count", 0

      task4.reload

      expect(task4.completed).must_equal false

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end
end
