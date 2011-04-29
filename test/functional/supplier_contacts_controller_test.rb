require 'test_helper'

class SupplierContactsControllerTest < ActionController::TestCase
  setup do
    @supplier_contact = supplier_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplier_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier_contact" do
    assert_difference('SupplierContact.count') do
      post :create, :supplier_contact => @supplier_contact.attributes
    end

    assert_redirected_to supplier_contact_path(assigns(:supplier_contact))
  end

  test "should show supplier_contact" do
    get :show, :id => @supplier_contact.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @supplier_contact.to_param
    assert_response :success
  end

  test "should update supplier_contact" do
    put :update, :id => @supplier_contact.to_param, :supplier_contact => @supplier_contact.attributes
    assert_redirected_to supplier_contact_path(assigns(:supplier_contact))
  end

  test "should destroy supplier_contact" do
    assert_difference('SupplierContact.count', -1) do
      delete :destroy, :id => @supplier_contact.to_param
    end

    assert_redirected_to supplier_contacts_path
  end
end
