require 'test_helper'

module Financeiro
  class PeriodoCobrancasControllerTest < ActionController::TestCase
    setup do
      @periodo_cobranca = periodo_cobrancas(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:periodo_cobrancas)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create periodo_cobranca" do
      assert_difference('PeriodoCobranca.count') do
        post :create, periodo_cobranca: { descricao: @periodo_cobranca.descricao, tipo: @periodo_cobranca.tipo }
      end

      assert_redirected_to periodo_cobranca_path(assigns(:periodo_cobranca))
    end

    test "should show periodo_cobranca" do
      get :show, id: @periodo_cobranca
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @periodo_cobranca
      assert_response :success
    end

    test "should update periodo_cobranca" do
      patch :update, id: @periodo_cobranca, periodo_cobranca: { descricao: @periodo_cobranca.descricao, tipo: @periodo_cobranca.tipo }
      assert_redirected_to periodo_cobranca_path(assigns(:periodo_cobranca))
    end

    test "should destroy periodo_cobranca" do
      assert_difference('PeriodoCobranca.count', -1) do
        delete :destroy, id: @periodo_cobranca
      end

      assert_redirected_to periodo_cobrancas_path
    end
  end
end
