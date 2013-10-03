require_dependency "financeiro/application_controller"

module Financeiro
  
  class CheckoutController < ApplicationController
    
    def pagar
      evento_financeiro = Financeiro::FinanceiroService.find_evento_financeiro(params[:id], params[:classe])
      
      config = Financeiro::FinanceiroConfiguracao.first
      
      payment = PagSeguro::PaymentRequest.new
      payment.reference = evento_financeiro.id
      payment.notification_url = config.notification_url if config.present?
      payment.redirect_url = config.redirect_url if config.present?

      if evento_financeiro.get_association.itens.present?
        evento_financeiro.get_association.item_pedidos.each do |item|
          payment.items << {
            id: item.produto.id,
            description: item.produto.nome,
            amount: item.produto.valor.to_f,
            weight: item.produto.peso.to_i
          }
        end
      end

      response = payment.register

      # Caso o processo de checkout tenha dado errado, lança uma exceção.
      # Assim, um serviço de rastreamento de exceções ou até mesmo a gem
      # exception_notification poderá notificar sobre o ocorrido.
      #
      # Se estiver tudo certo, redireciona o comprador para o PagSeguro.
      if response.errors.any?
        raise response.errors.join("\n")
      else
        redirect_to response.url
      end
    end
    
  end
  
end
