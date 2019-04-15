# frozen_string_literal: true

# require "test_helper"

# describe TodosController do
#   it "should get index" do
#     get todos_index_url
#     value(response).must_be :success?
#   end

# end
require 'test_helper'

describe TodosController do
  # Note to students:  Your todo model **may** be different and
  #   you may need to modify this.
  let (:todo) do
    Todo.create name: 'sample todo', description: 'this is an example for a test',
                completed: false
  end

  # Tests for Wave 1
  describe 'index' do
    it 'can get the index path' do
      # Act
      get todos_path

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
    it 'can get a valid todo' do
      # Act
      get todo_path(todo.id)

      # Assert
      must_respond_with :success
    end

    it 'will redirect for an invalid todo' do
      # Act
      get todo_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'can get the new todo page' do
      # Act
      get new_todo_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new todo' do
      # Arrange
      # Note to students:  Your todo model **may** be different and
      #   you may need to modify this.
      todo_hash = {
        todo: {
          name: 'new todo',
          description: 'new todo description',
          completed: false
        }
      }

      # Act-Assert
      expect do
        post todos_path, params: todo_hash
      end.must_change 'todo.count', 1

      new_todo = Todo.find_by(name: todo_hash[:todo][:name])
      expect(new_todo.description).must_equal todo_hash[:todo][:description]
      expect(new_todo.completed).must_equal todo_hash[:todo][:completed]

      must_respond_with :redirect
      must_redirect_to todos_path
    end
  end

  # Unskip and complete these tests for Wave 3
  describe 'edit' do
    it 'can get the edit page for an existing todo' do
      skip
      # Your code here
    end

    it 'will respond with redirect when attempting to edit a nonexistant todo' do
      skip
      # Your code here
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe 'update' do
    # Note:  If there was a way to fail to save the changes to a todo, that would be a great
    #        thing to test.
    it 'can update an existing todo' do
      skip
      # Your code here
    end

    it 'will redirect to the root page if given an invalid id' do
      skip
      # Your code here
    end
  end

  # Complete these tests for Wave 4
  describe 'destroy' do
    it 'will redirect if ID is invalid' do
      invalid_id = 'NOT A VALID ID'

      delete todo_path(invalid_id)

      must_respond_with :redirect
    end

    it 'can delete a task' do
      new_todo = Todo.create(name: 'start code hw')

      expect do
        delete todo_path(new_todo)
      end.must_change 'Todo.count', -1

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  # Complete for Wave 4
  describe 'toggle_complete' do
    # Your tests go here
  end
end
