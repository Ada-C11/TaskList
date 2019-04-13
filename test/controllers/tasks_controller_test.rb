require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: false
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
          completion_date: "false",
        },
      }

      # Act-Assert
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

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # Act
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      #Act
      get edit_task_path(123456)

      #Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      #Arrange
      task = Task.create!(
        name: "test task",
        description: "test description",
        completion_date: "test date",
      )

      task_hash = {
        task: {
          name: "test name change",
          description: "test description change",
          completion_date: "test date change",
        },
      }

      #Act
      patch task_path task.id, params: task_hash

      #Assert
      must_respond_with :redirect
      must_redirect_to task_path(task.id)
    end

    it "will redirect to the root page if given an invalid id" do
      #Act
      patch task_path 12345

      #Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it "removes a task from the database" do

      #Arrange
      task = Task.create!(name: "test task!")

      #Act
      expect {
        delete task_path(task)
      }.must_change "Task.count", -1

      #Assert
      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it "returns a 404 if the task doesn't exist" do

      #Arrange
      task_id = 9001

      #Assumptions
      expect(Task.find_by(id: task_id)).must_be_nil

      #Act
      expect {
        delete task_path(task_id)
      }.wont_change "Task.count"

      #Assert
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "updates the 'completed' attribute of a task" do
      #Arrange
      task = Task.create!(name: "test task!", completed: true)

      #Assumption
      expect(task.completed).must_equal true

      #Act
      patch toggle_complete_task_path(task.id)

      updated_task = Task.find_by(id: task.id)

      #Assert
      expect(updated_task.completed).must_equal false
    end

    it "returns a 404 if the task doesn't exist" do

      #Arrange
      task_id = 9001

      #Act
      patch toggle_complete_task_path(task_id)

      #Assert
      must_respond_with :not_found
    end
  end
end
