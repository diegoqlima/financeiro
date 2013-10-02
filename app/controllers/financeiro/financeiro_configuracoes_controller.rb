require_dependency "financeiro/application_controller"

module Financeiro
  class FinanceiroConfiguracoesController < ApplicationController
    before_action :set_configuracao, only: [:show, :edit, :update, :destroy]

    # GET /configuracaos
    def index
      @configuracaos = FinanceiroConfiguracao.all
    end

    # GET /configuracaos/1
    def show
    end

    # GET /configuracaos/new
    def new
      @configuracao = FinanceiroConfiguracao.new
    end

    # GET /configuracaos/1/edit
    def edit
    end

    # POST /configuracaos
    def create
      @configuracao = FinanceiroConfiguracao.new(configuracao_params)

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
        @configuracao = FinanceiroConfiguracao.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def configuracao_params
        params.require(:financeiro_configuracao).permit(:email_pagseguro, :token_pagseguro, :notification_url, :redirect_url)
      end
  end
end
