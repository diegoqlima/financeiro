module Financeiro
  class ContratoCobranca < ActiveRecord::Base
    belongs_to :conta
    
    scope :ativos, where(ativo: true)
    
    # metodo usado na tela de contribuicoes
    def formatted_name
      "#{titular} - #{nome_banco} - Ag: #{agencia} - Cedente: #{numero_contrato}"
    end
  
    def to_s
       "#{conta.titular} - #{conta.banco.nome} - Ag: #{conta.agencia} - Cedente: #{numero_contrato}"
    end
  end
end
