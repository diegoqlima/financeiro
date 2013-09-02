require_dependency "financeiro/application_controller"

module Financeiro
  class TipoArquivosController < ApplicationController
    before_action :set_tipo_arquivo, only: [:show, :edit, :update, :destroy]

    # GET /tipo_arquivos
    def index
      @tipo_arquivos = TipoArquivo.all
    end

    # GET /tipo_arquivos/1
    def show
    end

    # GET /tipo_arquivos/new
    def new
      @tipo_arquivo = TipoArquivo.new
    end

    # GET /tipo_arquivos/1/edit
    def edit
    end

    # POST /tipo_arquivos
    def create
      @tipo_arquivo = TipoArquivo.new(tipo_arquivo_params)

      if @tipo_arquivo.save
        redirect_to @tipo_arquivo, notice: 'Tipo arquivo was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /tipo_arquivos/1
    def update
      if @tipo_arquivo.update(tipo_arquivo_params)
        redirect_to @tipo_arquivo, notice: 'Tipo arquivo was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /tipo_arquivos/1
    def destroy
      @tipo_arquivo.destroy
      redirect_to tipo_arquivos_url, notice: 'Tipo arquivo was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tipo_arquivo
        @tipo_arquivo = TipoArquivo.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def tipo_arquivo_params
        params.require(:tipo_arquivo).permit(:descricao, :meio_pagamento_id, :entrada, :spec)
      end
  end
end
