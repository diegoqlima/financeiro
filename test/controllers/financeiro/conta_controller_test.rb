require 'test_helper'

module Financeiro
  class ContaControllerTest < ActionController::TestCase
    setup do
      @conta = conta(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:conta)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create conta" do
      assert_difference('Conta.count') do
        post :create, conta: { agencia: @conta.agencia, banco_id: @conta.banco_id }
      end

      assert_redirected_to conta_path(assigns(:conta))
    end

    test "should show conta" do
      get :show, id: @conta
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @conta
      assert_response :success
    end

    test "should update conta" do
      patch :update, id: @conta, conta: { agencia: @conta.agencia, banco_id: @conta.banco_id }
      assert_redirected_to conta_path(assigns(:conta))
    end

    test "should destroy conta" do
      assert_difference('Conta.count', -1) do
        delete :destroy, id: @conta
      end

      assert_redirected_to conta_path
    end
  end
end
