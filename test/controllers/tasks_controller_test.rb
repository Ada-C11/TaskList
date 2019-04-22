# frozen_string_literal: true

require 'test_helper'

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) do
    Task.create name: 'sample task', description: 'this is an example for a test',
                completed: false
  end

  # Tests for Wave 1
  describe 'index' do
    it 'can get the index path' do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it 'can get the root path' do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  # Unskip these tests for Wave 2
  describe 'show' do
    it 'can get a valid task' do
      skip
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it 'will redirect for an invalid task' do
      skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'can get the new task page' do
      skip

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new task' do
      skip

      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          name: 'new task',
          description: 'new task description',
          completed: false
        }
      }

      # Act-Assert
      expect do
        post tasks_path, params: task_hash
      end.must_change 'Task.count', 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed).must_equal task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Unskip and complete these tests for Wave 3
  describe 'edit' do
    it 'can get the edit page for an existing task' do
      get edit_task_path(task.id)
      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant task' do
      get task_path(-1)
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  # done in class on Friday
  describe 'update' do
    it 'changes the data on the model' do
      task = Task.create!(title: 'original')
      task_data = {
        task: {
          title: 'changed'
        }
      }
      patch task_path(task), params: task_data

      must_respond_with :redirect
      must_redirect_to task_path(task)

      expect(task.title).must_equal(task_data[:task][:title])
    end
  end

  it 'can update an existing task' do
    it 'can update an existing task' do
      task = Task.create!(name: 'run 5 miles')
      task_data = {
        task: {
          name: 'lift weights'
        }
      }
      patch task_path(task), params: task_data
      must_respond_with :redirect
      must_redirect_to task_path(task)
      task.reload
      expect(task.name).must_equal(task_data[:task][:name])
    end

    it 'will redirect to the root page if given an invalid id' do
      patch task_path(-1)
      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  # destroy test done in class
  describe 'destroy' do
    it 'removes a task from the database' do
      # arrange
      task = Task.create!(title: 'test_task')
      # act
      expect do
        delete task_path(task)
      end.must_change 'Task.count', -1
      # assert
      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end

    it "returns as 404 if the task doesn't exist" do
      task_id = 1234
      expect(Task.find_by(id: task_id)).must_be_nil
      expect do
        delete tasks_path(task_id)
      end.wont_change 'Task.count'
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe 'toggle_complete' do
    it 'can mark a task as complete' do
      task = Task.create!(
        name: 'get groceries',
        description: 'bananas, peppers, flour',
        completion_date: 'July 4, 2020'
      )
      patch toggle_complete_path(task)
      must_respond_with :redirect
      must_redirect_to tasks_path
      task.reload
      expect(task.completion_date).must_be_nil
      end
    end
  end
end
