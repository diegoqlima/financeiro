require_dependency "financeiro/application_controller"

module Financeiro
  class EventoFinanceirosController < ApplicationController
    before_action :set_evento_financeiro, only: [:show, :edit, :update, :destroy]

    # GET /evento_financeiros
    def index
      @evento_financeiros = EventoFinanceiro.all
    end

    # GET /evento_financeiros/1
    def show
    end

    # GET /evento_financeiros/new
    def new
      @evento_financeiro = EventoFinanceiro.new
    end

    # GET /evento_financeiros/1/edit
    def edit
    end

    # POST /evento_financeiros
    def create
      @evento_financeiro = EventoFinanceiro.new(evento_financeiro_params)

      if @evento_financeiro.save
        redirect_to @evento_financeiro, notice: 'Evento financeiro was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /evento_financeiros/1
    def update
      if @evento_financeiro.update(evento_financeiro_params)
        redirect_to @evento_financeiro, notice: 'Evento financeiro was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /evento_financeiros/1
    def destroy
      @evento_financeiro.destroy
      redirect_to evento_financeiros_url, notice: 'Evento financeiro was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_evento_financeiro
        @evento_financeiro = EventoFinanceiro.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def evento_financeiro_params
        params.require(:evento_financeiro).permit(:id, :inicio, :fim, :tipo_evento_financeiro_id, :meio_pagamento_id, :periodo_cobranca_id)
      end
  end
end
