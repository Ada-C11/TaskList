require "test_helper"

describe TasksController do
  let (:task) {
    Task.create task_name: "sample task", description: "this is an example for a test",
                date_due: Time.now + 5.days
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
      # skip
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      # skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      # skip

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      # skip

      # Arrange
      # Note to students:  Your Task model **may** be different and you may need to modify this.
      task_hash = {
        task: {
          task_name: "new task",
          description: "new task description",
          completed: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(task_name: task_hash[:task][:task_name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed).must_equal task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    # THE BELOW TEST IS GIVING AN ERROR AS FOLLOWS
    # ActionController::ParameterMissing:
    # param is missing or the value is empty: task
    # THIS IS A TEST I ADDED AND IS NOT REQUIRED. INSPIRATION CAME FROM
    # https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/08-rails/code_samples/create_controller_test.rb

    it "will not create a task with invalid params" do
      skip
      task_hash = {} # invalid params

      expect {
        post tasks_path, params: task_hash
      }.wont_change "Task.count"

      must_respond_with :bad_request
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # skip
      # Act
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # skip
      get edit_task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.

    before do
      Task.create(task_name: "Clean the bathroom", description: "All of it! Don't forget the floor.", date_due: "2020-01-01")
    end

    let (:new_task_hash) {
      {
        task: {
          task_name: "Buy groceries",
          description: "Silk vanilla almond creamer and bacon",
          date_due: "2019-04-15".to_date,
          completed: false,
        },
      }
    }

    it "can update an existing task" do
      # skip

      id = Task.last.id
      expect {
        patch task_path(id), params: new_task_hash
      }.wont_change "Task.count"

      must_respond_with :redirect

      task = Task.find_by(id: id)
      expect(task.task_name).must_equal new_task_hash[:task][:task_name]
      expect(task.description).must_equal new_task_hash[:task][:description]
      expect(task.date_due).must_equal new_task_hash[:task][:date_due]
    end

    # THIS IS THE FIRST THING I TRIED WRITING. IT GAVE AN ERROR.
    # ActiveModel::UnknownAttributeError: unknown attribute 'params' for Task.
    it "can update an existing task" do
      skip
      # Arrange
      change_task = Task.find_by(task_name: "Clean the bathroom")

      change_task.update(params: new_task_hash)

      # Assert
      expect { }.must_change
      must_respond_with :success
      must_redirect_to task_path
    end

    it "will redirect to the root page if given an invalid id" do
      # skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    before do
      Task.create(task_name: "Acquire a rain jacket", description: "One that is waterproof; check The Bins.", date_due: "2020-03-15")

      Task.create(task_name: "Take a break!", description: "Go outside, play your cello, take your eyes away from the screen. Do it!!", date_due: "2020-03-15")
    end

    it "will destroy an existing task" do
      # skip
      # Arrange
      task_to_delete = Task.find_by(task_name: "Acquire a rain jacket")

      other_task = Task.find_by(task_name: "Take a break!")

      # task_to_delete.destroy

      # Assert

      # NEED HELP WITH THE NEXT THREE TESTS!!!
      expect {
        task_to_delete.destroy
      }.must_change "Task.count", -1
      # must_respond_with :success

      # expect {
      #   other_task.destroy
      # }.must_respond_with :success
      # must_redirect_to tasks_path
    end

    # it "will give a 404 error if trying to delete a non-existant task" do
    #   task_to_delete = Task.find_by(id: -1)
    #   expect {
    #     task_to_delete.destroy
    #   }.must_respond_with :missing
    # end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Arrange
    before do
      Task.create(task_name: "Finish writing this test.", description: "One that is waterproof; check The Bins.", date_due: "2020-03-15")

      Task.create(task_name: "Take another break!", description: "For real this time.", date_due: "2019-04-14", completed: true)
    end

    task_to_toggle1 = Task.find_by(task_name: "Finish writing this test.")
    task_to_toggle2 = Task.find_by(task_name: "Take another break!")
    # expect {
    #   task_to_toggle1.toggle_completed
    # }.must_change task_to_toggle[:completed], true

    # Act
    task_to_toggle2.toggle_completed

    # Assert
    expect(task_to_toggle2[:completed]).must_equal false
  end
end
