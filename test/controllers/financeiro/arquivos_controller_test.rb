require 'test_helper'

module Financeiro
  class ArquivosControllerTest < ActionController::TestCase
    setup do
      @arquivo = arquivos(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:arquivos)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create arquivo" do
      assert_difference('Arquivo.count') do
        post :create, arquivo: { nome: @arquivo.nome, parametros: @arquivo.parametros, tipo_arquivo_id: @arquivo.tipo_arquivo_id }
      end

      assert_redirected_to arquivo_path(assigns(:arquivo))
    end

    test "should show arquivo" do
      get :show, id: @arquivo
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @arquivo
      assert_response :success
    end

    test "should update arquivo" do
      patch :update, id: @arquivo, arquivo: { nome: @arquivo.nome, parametros: @arquivo.parametros, tipo_arquivo_id: @arquivo.tipo_arquivo_id }
      assert_redirected_to arquivo_path(assigns(:arquivo))
    end

    test "should destroy arquivo" do
      assert_difference('Arquivo.count', -1) do
        delete :destroy, id: @arquivo
      end

      assert_redirected_to arquivos_path
    end
  end
end
