require_dependency "financeiro/application_controller"

module Financeiro
  class TipoEventoFinanceirosController < ApplicationController
    before_action :set_tipo_evento_financeiro, only: [:show, :edit, :update, :destroy]

    # GET /tipo_evento_financeiros
    def index
      @tipo_evento_financeiros = TipoEventoFinanceiro.all
    end

    # GET /tipo_evento_financeiros/1
    def show
    end

    # GET /tipo_evento_financeiros/new
    def new
      @tipo_evento_financeiro = TipoEventoFinanceiro.new
    end

    # GET /tipo_evento_financeiros/1/edit
    def edit
    end

    # POST /tipo_evento_financeiros
    def create
      @tipo_evento_financeiro = TipoEventoFinanceiro.new(tipo_evento_financeiro_params)

      if @tipo_evento_financeiro.save
        redirect_to @tipo_evento_financeiro, notice: 'Tipo evento financeiro was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /tipo_evento_financeiros/1
    def update
      if @tipo_evento_financeiro.update(tipo_evento_financeiro_params)
        redirect_to @tipo_evento_financeiro, notice: 'Tipo evento financeiro was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /tipo_evento_financeiros/1
    def destroy
      @tipo_evento_financeiro.destroy
      redirect_to tipo_evento_financeiros_url, notice: 'Tipo evento financeiro was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tipo_evento_financeiro
        @tipo_evento_financeiro = TipoEventoFinanceiro.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def tipo_evento_financeiro_params
        params.require(:tipo_evento_financeiro).permit(:id, :descricao)
      end
  end
end
