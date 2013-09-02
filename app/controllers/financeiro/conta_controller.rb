require_dependency "financeiro/application_controller"

module Financeiro
  class ContaController < ApplicationController
    before_action :set_conta, only: [:show, :edit, :update, :destroy]

    # GET /conta
    def index
      @conta = Conta.all
    end

    # GET /conta/1
    def show
    end

    # GET /conta/new
    def new
      @conta = Conta.new
    end

    # GET /conta/1/edit
    def edit
    end

    # POST /conta
    def create
      @conta = Conta.new(conta_params)

      if @conta.save
        redirect_to @conta, notice: 'Conta was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /conta/1
    def update
      if @conta.update(conta_params)
        redirect_to @conta, notice: 'Conta was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /conta/1
    def destroy
      @conta.destroy
      redirect_to conta_url, notice: 'Conta was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_conta
        @conta = Conta.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def conta_params
        params.require(:conta).permit(:banco_id, :agencia)
      end
  end
end
