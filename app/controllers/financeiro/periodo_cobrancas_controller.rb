require_dependency "financeiro/application_controller"

module Financeiro
  class PeriodoCobrancasController < ApplicationController
    before_action :set_periodo_cobranca, only: [:show, :edit, :update, :destroy]

    # GET /periodo_cobrancas
    def index
      @periodo_cobrancas = PeriodoCobranca.all
    end

    # GET /periodo_cobrancas/1
    def show
    end

    # GET /periodo_cobrancas/new
    def new
      @periodo_cobranca = PeriodoCobranca.new
    end

    # GET /periodo_cobrancas/1/edit
    def edit
    end

    # POST /periodo_cobrancas
    def create
      @periodo_cobranca = PeriodoCobranca.new(periodo_cobranca_params)

      if @periodo_cobranca.save
        redirect_to @periodo_cobranca, notice: 'Periodo cobranca was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /periodo_cobrancas/1
    def update
      if @periodo_cobranca.update(periodo_cobranca_params)
        redirect_to @periodo_cobranca, notice: 'Periodo cobranca was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /periodo_cobrancas/1
    def destroy
      @periodo_cobranca.destroy
      redirect_to periodo_cobrancas_url, notice: 'Periodo cobranca was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_periodo_cobranca
        @periodo_cobranca = PeriodoCobranca.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def periodo_cobranca_params
        params.require(:periodo_cobranca).permit(:descricao, :tipo)
      end
  end
end
