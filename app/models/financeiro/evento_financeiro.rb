module Financeiro
  class EventoFinanceiro < ActiveRecord::Base
    belongs_to :tipo_evento_financeiro, class_name: "Financeiro::TipoEventoFinanceiro"
    belongs_to :meio_pagamento, class_name: "Financeiro::MeioPagamento"
    belongs_to :periodo_cobranca, class_name: "Financeiro::PeriodoCobranca"
    has_many :pagamentos, class_name: "Financeiro::Pagamento", dependent: :destroy
    
    validates_presence_of :valor, message: "O valor deve ser informado"
    validates_presence_of :tipo_evento_financeiro, message: "Informe o tipo da contribuição"
    validates_presence_of :meio_pagamento, message: "Informe o meio de pagamento"
    validates_presence_of :periodo_cobranca, message: "É preciso informar a unidade"
    
    after_save :cria_pagamentos
    
    def cria_pagamentos
      # verifica se já existe pagamento para a data de referencia
      p = Financeiro::Pagamento.where(evento_financeiro: self, data_vencimento: self.inicio)
      #Somente cria pagamentos na hora se o pagamento for para o mesmo dia
      if(inicio == Date.today and p.empty?)
        self.pagamentos.create(valor: self.valor, data_vencimento: inicio)
      end

      #Somente cria pagamentos na hora se o pagamento for boleto
      boleto = Financeiro::MeioPagamento.BOLETO.id
      if(self.meio_pagamento_id == boleto && p.empty?)
        inicio = DateTime.new(self.inicio.year, self.inicio.month, self.vencimento_boleto.day)
        self.pagamentos.create(:valor => self.valor, :data_vencimento => inicio)
      end

      #Quando esta atualizando, atualiza o valor de todos os pagamentos virgens
      Financeiro::Pagamento.where("evento_financeiro_id = ? and state is null",self.id).each do |p|
        p.valor = self.valor
      end

    end
    
    # Metodo utilizado para notificar o modelo responsavel quando um pagamento for cancelado
    def notificar_pagamento_cancelado
      self.association_class.constantize.find_by(id: self.association_id).pagamento_cancelado
    end
    
    # Metodo utilizado para notificar o modelo responsavel quando um pagamento for efetuado
    def notificar_pagamento_efetuado
      self.association_class.constantize.find_by(id: self.association_id).pagamento_efetuado
    end
    
    # Metodo utilizado para notificar o modelo responsavel quando esta aguardando um pagamento
    def notificar_aguardando_pagamento
      self.association_class.constantize.find_by(id: self.association_id).aguardando_pagamento
    end
    
    # Metodo utilizado para notificar o modelo responsavel quando um pagamento esta em analise
    def notificar_pagamento_em_analise
      self.association_class.constantize.find_by(id: self.association_id).pagamento_em_analise
    end
    
    # Metodo utilizado para notificar o modelo responsavel quando um pagamento esta em disputa
    def notificar_pagamento_em_disputa
      self.association_class.constantize.find_by(id: self.association_id).pagamento_em_disputa
    end
    
    # Metodo utilizado para notificar o modelo responsavel quando um pagamento esta estornado
    def notificar_pagamento_estornado
      self.association_class.constantize.find_by(id: self.association_id).pagamento_estornado
    end
    
    def get_association
      self.association_class.constantize.find_by(id: self.association_id)
    end
    
  end
end
