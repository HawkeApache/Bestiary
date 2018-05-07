require 'test_helper'

class BeastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beast = beasts(:one)
  end

  test "should get index" do
    get beasts_url
    assert_response :success
  end

  test "should get new" do
    get new_beast_url
    assert_response :success
  end

  test "should create beast" do
    assert_difference('Beast.count') do
      post beasts_url, params: { beast: { bio: @beast.bio, degree: @beast.degree, firstname: @beast.firstname, lastname: @beast.lastname, pseudo: @beast.pseudo, rating: @beast.rating } }
    end

    assert_redirected_to beast_url(Beast.last)
  end

  test "should show beast" do
    get beast_url(@beast)
    assert_response :success
  end

  test "should get edit" do
    get edit_beast_url(@beast)
    assert_response :success
  end

  test "should update beast" do
    patch beast_url(@beast), params: { beast: { bio: @beast.bio, degree: @beast.degree, firstname: @beast.firstname, lastname: @beast.lastname, pseudo: @beast.pseudo, rating: @beast.rating } }
    assert_redirected_to beast_url(@beast)
  end

  test "should destroy beast" do
    assert_difference('Beast.count', -1) do
      delete beast_url(@beast)
    end

    assert_redirected_to beasts_url
  end
end
