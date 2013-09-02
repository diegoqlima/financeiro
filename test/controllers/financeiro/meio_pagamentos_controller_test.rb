require 'test_helper'

module Financeiro
  class MeioPagamentosControllerTest < ActionController::TestCase
    setup do
      @meio_pagamento = meio_pagamentos(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:meio_pagamentos)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create meio_pagamento" do
      assert_difference('MeioPagamento.count') do
        post :create, meio_pagamento: { descricao: @meio_pagamento.descricao, nome: @meio_pagamento.nome }
      end

      assert_redirected_to meio_pagamento_path(assigns(:meio_pagamento))
    end

    test "should show meio_pagamento" do
      get :show, id: @meio_pagamento
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @meio_pagamento
      assert_response :success
    end

    test "should update meio_pagamento" do
      patch :update, id: @meio_pagamento, meio_pagamento: { descricao: @meio_pagamento.descricao, nome: @meio_pagamento.nome }
      assert_redirected_to meio_pagamento_path(assigns(:meio_pagamento))
    end

    test "should destroy meio_pagamento" do
      assert_difference('MeioPagamento.count', -1) do
        delete :destroy, id: @meio_pagamento
      end

      assert_redirected_to meio_pagamentos_path
    end
  end
end
