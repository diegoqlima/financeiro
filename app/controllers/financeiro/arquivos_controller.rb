require_dependency "financeiro/application_controller"

module Financeiro
  class ArquivosController < ApplicationController
    before_action :set_arquivo, only: [:show, :edit, :update, :destroy]

    # GET /arquivos
    def index
      @arquivos = Arquivo.all
    end

    # GET /arquivos/1
    def show
    end

    # GET /arquivos/new
    def new
      @arquivo = Arquivo.new
    end

    # GET /arquivos/1/edit
    def edit
    end

    # POST /arquivos
    def create
      @arquivo = Arquivo.new(arquivo_params)

      if @arquivo.save
        redirect_to @arquivo, notice: 'Arquivo was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /arquivos/1
    def update
      if @arquivo.update(arquivo_params)
        redirect_to @arquivo, notice: 'Arquivo was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /arquivos/1
    def destroy
      @arquivo.destroy
      redirect_to arquivos_url, notice: 'Arquivo was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_arquivo
        @arquivo = Arquivo.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def arquivo_params
        params.require(:arquivo).permit(:tipo_arquivo_id, :parametros, :nome, :data_file)
      end
  end
end
