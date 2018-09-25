require 'test_helper'

class EditControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get edit_index_url
    assert_response :success
  end

end
