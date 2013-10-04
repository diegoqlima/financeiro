module Financeiro
  class Conta < ActiveRecord::Base
    belongs_to :banco
    has_many :contrato_cobrancas
    
    accepts_nested_attributes_for :contrato_cobrancas, allow_destroy: true
    
    validates_presence_of :banco
    validates_presence_of :agencia
    validates_presence_of :numero_conta
    
    TIPO_CONTA = {
      "Corrente" => "corrente",
      "Poupança" => "poupanca"
    }
    
  end
end
