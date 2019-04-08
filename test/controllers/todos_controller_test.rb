require "test_helper"

describe TodosController do
  it "should get index" do
    get todos_index_url
    value(response).must_be :success?
  end

end
