require 'test_helper'

module Financeiro
  class FinanceiroConfiguracoesControllerTest < ActionController::TestCase
    setup do
      @configuracao = configuracaos(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:configuracaos)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create configuracao" do
      assert_difference('Configuracao.count') do
        post :create, configuracao: { email_pagseguro: @configuracao.email_pagseguro, token_pagseguro: @configuracao.token_pagseguro }
      end

      assert_redirected_to configuracao_path(assigns(:configuracao))
    end

    test "should show configuracao" do
      get :show, id: @configuracao
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @configuracao
      assert_response :success
    end

    test "should update configuracao" do
      patch :update, id: @configuracao, configuracao: { email_pagseguro: @configuracao.email_pagseguro, token_pagseguro: @configuracao.token_pagseguro }
      assert_redirected_to configuracao_path(assigns(:configuracao))
    end

    test "should destroy configuracao" do
      assert_difference('Configuracao.count', -1) do
        delete :destroy, id: @configuracao
      end

      assert_redirected_to configuracaos_path
    end
  end
end
