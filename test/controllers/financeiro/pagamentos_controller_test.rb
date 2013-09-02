require 'test_helper'

module Financeiro
  class PagamentosControllerTest < ActionController::TestCase
    setup do
      @pagamento = pagamentos(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:pagamentos)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create pagamento" do
      assert_difference('Pagamento.count') do
        post :create, pagamento: { data_pagamento: @pagamento.data_pagamento, data_vencimento: @pagamento.data_vencimento, evento_financeiro_id: @pagamento.evento_financeiro_id, id: @pagamento.id, state: @pagamento.state, valor: @pagamento.valor }
      end

      assert_redirected_to pagamento_path(assigns(:pagamento))
    end

    test "should show pagamento" do
      get :show, id: @pagamento
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @pagamento
      assert_response :success
    end

    test "should update pagamento" do
      patch :update, id: @pagamento, pagamento: { data_pagamento: @pagamento.data_pagamento, data_vencimento: @pagamento.data_vencimento, evento_financeiro_id: @pagamento.evento_financeiro_id, id: @pagamento.id, state: @pagamento.state, valor: @pagamento.valor }
      assert_redirected_to pagamento_path(assigns(:pagamento))
    end

    test "should destroy pagamento" do
      assert_difference('Pagamento.count', -1) do
        delete :destroy, id: @pagamento
      end

      assert_redirected_to pagamentos_path
    end
  end
end
