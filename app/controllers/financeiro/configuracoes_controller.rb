require_dependency "financeiro/application_controller"

module Financeiro
  class ConfiguracoesController < ApplicationController
    before_action :set_configuracao, only: [:show, :edit, :update, :destroy]

    # GET /configuracaos
    def index
      @configuracaos = Configuracao.all
    end

    # GET /configuracaos/1
    def show
    end

    # GET /configuracaos/new
    def new
      @configuracao = Configuracao.new
    end

    # GET /configuracaos/1/edit
    def edit
    end

    # POST /configuracaos
    def create
      @configuracao = Configuracao.new(configuracao_params)

      if @configuracao.save
        redirect_to @configuracao, notice: 'Configuracao was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /configuracaos/1
    def update
      if @configuracao.update(configuracao_params)
        redirect_to @configuracao, notice: 'Configuracao was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /configuracaos/1
    def destroy
      @configuracao.destroy
      redirect_to configuracaos_url, notice: 'Configuracao was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_configuracao
        @configuracao = Configuracao.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def configuracao_params
        params.require(:configuracao).permit(:email_pagseguro, :token_pagseguro, :notification_url, :redirect_url)
      end
  end
end
