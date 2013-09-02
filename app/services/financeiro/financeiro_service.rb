module Financeiro
  class FinanceiroService
    
    # Cria um evento financeiro para o modelo que for passado como parametro
    #
    # Params:
    # - valor: valor do evento financeiro
    # - inicio: inicio do evento financeiro
    # - fim: fim do evento financeiro
    # - tipo_evento_financeiro: Tipo do Evento Financeiro(Contribuicao Social, Certidao de Casamento)
    # - meio_pagamento: Meio de Pagamento(carne, boleto, cartao, etc..)
    # - periodo_cobranca: Periodo de Cobranca(Anual, Semestral, Mensal, etc...)
    # - association_id: ID do objeto a ser associado
    # - association_class: Nome da classe de associacao. Ex:(Curso, Produto, etc...)
    def self.criar_evento_financeiro(valor, inicio, fim, tipo_evento_financeiro, meio_pagamento, periodo_cobranca, association_id, association_class)
      ef = Financeiro::EventoFinanceiro.new(valor: valor, inicio: inicio, fim: fim, tipo_evento_financeiro: tipo_evento_financeiro, meio_pagamento: meio_pagamento, periodo_cobranca: periodo_cobranca, association_id: association_id, association_class: association_class)
      ef.save!
    end

    # Procura um evento financeiro a partir do id e do nome da classe da associacao
    #
    # Params:
    # - association_id: ID do objeto a ser associado
    # - association_class: Nome da classe de associacao. Ex:(Curso, Produto, etc...)    
    def self.find_evento_financeiro(association_id, association_class)
      Financeiro::EventoFinanceiro.find_by(association_id: association_id, association_class: association_class)
    end
    
  end
end
