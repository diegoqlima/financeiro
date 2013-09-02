module Financeiro
  class Pagamento < ActiveRecord::Base
    include ActiveModel::Transitions
    
    belongs_to :evento_financeiro
    has_many :registros, dependent: :destroy
    
    state_machine do
      state :iniciado # first one is initial state
      state :cancelado, enter: lambda { |pg| pg.notificar_cancelamento }
      state :efetuado, enter: lambda { |pg| pg.notificar_sucesso }
      
      event :cancelar_pagamento do
        transitions :to => :cancelado, :from => [:iniciado]
      end

      event :efetuar_pagamento do
        transitions :to => :efetuado, :from => [:iniciado]
      end
    end
    
    def notificar_cancelamento
      self.evento_financeiro.notificar_pagamento_cancelado
    end
    
    def notificar_sucesso
      self.evento_financeiro.notificar_pagamento_efetuado
    end
    
  end
end
