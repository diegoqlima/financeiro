require 'test_helper'

module Financeiro
  class EventoFinanceirosControllerTest < ActionController::TestCase
    setup do
      @evento_financeiro = evento_financeiros(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:evento_financeiros)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create evento_financeiro" do
      assert_difference('EventoFinanceiro.count') do
        post :create, evento_financeiro: { data: @evento_financeiro.data, id: @evento_financeiro.id, tipo_evento_financeiro_id: @evento_financeiro.tipo_evento_financeiro_id }
      end

      assert_redirected_to evento_financeiro_path(assigns(:evento_financeiro))
    end

    test "should show evento_financeiro" do
      get :show, id: @evento_financeiro
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @evento_financeiro
      assert_response :success
    end

    test "should update evento_financeiro" do
      patch :update, id: @evento_financeiro, evento_financeiro: { data: @evento_financeiro.data, id: @evento_financeiro.id, tipo_evento_financeiro_id: @evento_financeiro.tipo_evento_financeiro_id }
      assert_redirected_to evento_financeiro_path(assigns(:evento_financeiro))
    end

    test "should destroy evento_financeiro" do
      assert_difference('EventoFinanceiro.count', -1) do
        delete :destroy, id: @evento_financeiro
      end

      assert_redirected_to evento_financeiros_path
    end
  end
end
