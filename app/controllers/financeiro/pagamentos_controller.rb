require_dependency "financeiro/application_controller"

module Financeiro
  class PagamentosController < ApplicationController
    before_action :set_pagamento, only: [:show, :edit, :update, :destroy]

    # GET /pagamentos
    def index
      @pagamentos = Pagamento.all
    end

    # GET /pagamentos/1
    def show
    end

    # GET /pagamentos/new
    def new
      @pagamento = Pagamento.new
    end

    # GET /pagamentos/1/edit
    def edit
    end

    # POST /pagamentos
    def create
      @pagamento = Pagamento.new(pagamento_params)

      if @pagamento.save
        redirect_to @pagamento, notice: 'Pagamento was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /pagamentos/1
    def update
      if @pagamento.update(pagamento_params)
        redirect_to @pagamento, notice: 'Pagamento was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /pagamentos/1
    def destroy
      @pagamento.destroy
      redirect_to pagamentos_url, notice: 'Pagamento was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_pagamento
        @pagamento = Pagamento.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def pagamento_params
        params.require(:pagamento).permit(:id, :valor, :state, :data_vencimento, :data_pagamento, :evento_financeiro_id)
      end
  end
end
