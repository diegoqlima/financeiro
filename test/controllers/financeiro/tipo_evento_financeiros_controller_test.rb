require 'test_helper'

module Financeiro
  class TipoEventoFinanceirosControllerTest < ActionController::TestCase
    setup do
      @tipo_evento_financeiro = tipo_evento_financeiros(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:tipo_evento_financeiros)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create tipo_evento_financeiro" do
      assert_difference('TipoEventoFinanceiro.count') do
        post :create, tipo_evento_financeiro: { descricao: @tipo_evento_financeiro.descricao, id: @tipo_evento_financeiro.id }
      end

      assert_redirected_to tipo_evento_financeiro_path(assigns(:tipo_evento_financeiro))
    end

    test "should show tipo_evento_financeiro" do
      get :show, id: @tipo_evento_financeiro
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @tipo_evento_financeiro
      assert_response :success
    end

    test "should update tipo_evento_financeiro" do
      patch :update, id: @tipo_evento_financeiro, tipo_evento_financeiro: { descricao: @tipo_evento_financeiro.descricao, id: @tipo_evento_financeiro.id }
      assert_redirected_to tipo_evento_financeiro_path(assigns(:tipo_evento_financeiro))
    end

    test "should destroy tipo_evento_financeiro" do
      assert_difference('TipoEventoFinanceiro.count', -1) do
        delete :destroy, id: @tipo_evento_financeiro
      end

      assert_redirected_to tipo_evento_financeiros_path
    end
  end
end
