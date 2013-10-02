require_dependency "financeiro/application_controller"

module Financeiro
  class CheckoutController < ApplicationController
    
    def create
      inscricao = Formulario.find(params[:id])

      payment = PagSeguro::PaymentRequest.new
      payment.reference = inscricao.id
      # payment.notification_url = notifications_url
      # payment.redirect_url = processing_url

      payment.items << {
        id: item.produto.id,
        description: item.produto.nome,
        amount: item.produto.valor.to_f,
      }

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
