require 'test_helper'

module Financeiro
  class TipoArquivosControllerTest < ActionController::TestCase
    setup do
      @tipo_arquivo = tipo_arquivos(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:tipo_arquivos)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create tipo_arquivo" do
      assert_difference('TipoArquivo.count') do
        post :create, tipo_arquivo: { descricao: @tipo_arquivo.descricao, entrada: @tipo_arquivo.entrada, meio_pagamento_id: @tipo_arquivo.meio_pagamento_id, spec: @tipo_arquivo.spec }
      end

      assert_redirected_to tipo_arquivo_path(assigns(:tipo_arquivo))
    end

    test "should show tipo_arquivo" do
      get :show, id: @tipo_arquivo
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @tipo_arquivo
      assert_response :success
    end

    test "should update tipo_arquivo" do
      patch :update, id: @tipo_arquivo, tipo_arquivo: { descricao: @tipo_arquivo.descricao, entrada: @tipo_arquivo.entrada, meio_pagamento_id: @tipo_arquivo.meio_pagamento_id, spec: @tipo_arquivo.spec }
      assert_redirected_to tipo_arquivo_path(assigns(:tipo_arquivo))
    end

    test "should destroy tipo_arquivo" do
      assert_difference('TipoArquivo.count', -1) do
        delete :destroy, id: @tipo_arquivo
      end

      assert_redirected_to tipo_arquivos_path
    end
  end
end
