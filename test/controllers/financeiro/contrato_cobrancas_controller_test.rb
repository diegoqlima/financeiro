require 'test_helper'

module Financeiro
  class ContratoCobrancasControllerTest < ActionController::TestCase
    setup do
      @contrato_cobranca = contrato_cobrancas(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:contrato_cobrancas)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create contrato_cobranca" do
      assert_difference('ContratoCobranca.count') do
        post :create, contrato_cobranca: { ativo: @contrato_cobranca.ativo, carteira: @contrato_cobranca.carteira, conta_id: @contrato_cobranca.conta_id, numero_contrato: @contrato_cobranca.numero_contrato }
      end

      assert_redirected_to contrato_cobranca_path(assigns(:contrato_cobranca))
    end

    test "should show contrato_cobranca" do
      get :show, id: @contrato_cobranca
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @contrato_cobranca
      assert_response :success
    end

    test "should update contrato_cobranca" do
      patch :update, id: @contrato_cobranca, contrato_cobranca: { ativo: @contrato_cobranca.ativo, carteira: @contrato_cobranca.carteira, conta_id: @contrato_cobranca.conta_id, numero_contrato: @contrato_cobranca.numero_contrato }
      assert_redirected_to contrato_cobranca_path(assigns(:contrato_cobranca))
    end

    test "should destroy contrato_cobranca" do
      assert_difference('ContratoCobranca.count', -1) do
        delete :destroy, id: @contrato_cobranca
      end

      assert_redirected_to contrato_cobrancas_path
    end
  end
end
