require_dependency "financeiro/application_controller"

module Financeiro
  class ContratoCobrancasController < ApplicationController
    before_action :set_contrato_cobranca, only: [:show, :edit, :update, :destroy]

    # GET /contrato_cobrancas
    def index
      @contrato_cobrancas = ContratoCobranca.all
    end

    # GET /contrato_cobrancas/1
    def show
    end

    # GET /contrato_cobrancas/new
    def new
      @contrato_cobranca = ContratoCobranca.new
    end

    # GET /contrato_cobrancas/1/edit
    def edit
    end

    # POST /contrato_cobrancas
    def create
      @contrato_cobranca = ContratoCobranca.new(contrato_cobranca_params)

      if @contrato_cobranca.save
        redirect_to @contrato_cobranca, notice: 'Contrato cobranca was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /contrato_cobrancas/1
    def update
      if @contrato_cobranca.update(contrato_cobranca_params)
        redirect_to @contrato_cobranca, notice: 'Contrato cobranca was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /contrato_cobrancas/1
    def destroy
      @contrato_cobranca.destroy
      redirect_to contrato_cobrancas_url, notice: 'Contrato cobranca was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contrato_cobranca
        @contrato_cobranca = ContratoCobranca.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def contrato_cobranca_params
        params.require(:contrato_cobranca).permit(:conta_id, :numero_contrato, :ativo, :carteira)
      end
  end
end
