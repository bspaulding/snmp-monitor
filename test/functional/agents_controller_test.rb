require 'test_helper'

class AgentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agent" do
    assert_difference('Agent.count') do
      post :create, :agent => { }
    end

    assert_redirected_to agent_path(assigns(:agent))
  end

  test "should show agent" do
    get :show, :id => agents(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => agents(:one).id
    assert_response :success
  end

  test "should update agent" do
    put :update, :id => agents(:one).id, :agent => { }
    assert_redirected_to agent_path(assigns(:agent))
  end

  test "should destroy agent" do
    assert_difference('Agent.count', -1) do
      delete :destroy, :id => agents(:one).id
    end

    assert_redirected_to agents_path
  end
end
