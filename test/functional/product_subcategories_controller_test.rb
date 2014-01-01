require 'test_helper'

class ProductSubcategoriesControllerTest < ActionController::TestCase
  setup do
    @product_subcategory = product_subcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_subcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_subcategory" do
    assert_difference('ProductSubcategory.count') do
      post :create, :product_subcategory => @product_subcategory.attributes
    end

    assert_redirected_to product_subcategory_path(assigns(:product_subcategory))
  end

  test "should show product_subcategory" do
    get :show, :id => @product_subcategory.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product_subcategory.to_param
    assert_response :success
  end

  test "should update product_subcategory" do
    put :update, :id => @product_subcategory.to_param, :product_subcategory => @product_subcategory.attributes
    assert_redirected_to product_subcategory_path(assigns(:product_subcategory))
  end

  test "should destroy product_subcategory" do
    assert_difference('ProductSubcategory.count', -1) do
      delete :destroy, :id => @product_subcategory.to_param
    end

    assert_redirected_to product_subcategories_path
  end
end
