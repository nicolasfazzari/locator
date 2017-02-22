require 'test_helper'

class BoitesControllerTest < ActionController::TestCase
  setup do
    @boite = boites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boite" do
    assert_difference('Boite.count') do
      post :create, boite: { boite: @boite.boite, commune: @boite.commune, departement: @boite.departement, latitude: @boite.latitude, longitude: @boite.longitude, zip: @boite.zip }
    end

    assert_redirected_to boite_path(assigns(:boite))
  end

  test "should show boite" do
    get :show, id: @boite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boite
    assert_response :success
  end

  test "should update boite" do
    patch :update, id: @boite, boite: { boite: @boite.boite, commune: @boite.commune, departement: @boite.departement, latitude: @boite.latitude, longitude: @boite.longitude, zip: @boite.zip }
    assert_redirected_to boite_path(assigns(:boite))
  end

  test "should destroy boite" do
    assert_difference('Boite.count', -1) do
      delete :destroy, id: @boite
    end

    assert_redirected_to boites_path
  end
end
