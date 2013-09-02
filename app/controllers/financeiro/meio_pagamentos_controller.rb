require_dependency "financeiro/application_controller"

module Financeiro
  class MeioPagamentosController < ApplicationController
    before_action :set_meio_pagamento, only: [:show, :edit, :update, :destroy]

    # GET /meio_pagamentos
    def index
      @meio_pagamentos = MeioPagamento.all
    end

    # GET /meio_pagamentos/1
    def show
    end

    # GET /meio_pagamentos/new
    def new
      @meio_pagamento = MeioPagamento.new
    end

    # GET /meio_pagamentos/1/edit
    def edit
    end

    # POST /meio_pagamentos
    def create
      @meio_pagamento = MeioPagamento.new(meio_pagamento_params)

      if @meio_pagamento.save
        redirect_to @meio_pagamento, notice: 'Meio pagamento was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /meio_pagamentos/1
    def update
      if @meio_pagamento.update(meio_pagamento_params)
        redirect_to @meio_pagamento, notice: 'Meio pagamento was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /meio_pagamentos/1
    def destroy
      @meio_pagamento.destroy
      redirect_to meio_pagamentos_url, notice: 'Meio pagamento was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_meio_pagamento
        @meio_pagamento = MeioPagamento.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def meio_pagamento_params
        params.require(:meio_pagamento).permit(:nome, :descricao)
      end
  end
end
