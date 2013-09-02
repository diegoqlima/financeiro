require_dependency "financeiro/application_controller"

module Financeiro
  class BancosController < ApplicationController
    before_action :set_banco, only: [:show, :edit, :update, :destroy]

    # GET /bancos
    def index
      @bancos = Banco.all
    end

    # GET /bancos/1
    def show
    end

    # GET /bancos/new
    def new
      @banco = Banco.new
    end

    # GET /bancos/1/edit
    def edit
    end

    # POST /bancos
    def create
      @banco = Banco.new(banco_params)

      if @banco.save
        redirect_to @banco, notice: 'Banco was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /bancos/1
    def update
      if @banco.update(banco_params)
        redirect_to @banco, notice: 'Banco was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /bancos/1
    def destroy
      @banco.destroy
      redirect_to bancos_url, notice: 'Banco was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_banco
        @banco = Banco.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def banco_params
        params.require(:banco).permit(:codigo, :nome)
      end
  end
end
