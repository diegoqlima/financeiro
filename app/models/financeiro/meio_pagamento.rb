module Financeiro
  class MeioPagamento < ActiveRecord::Base
    def bradesco?
      self.nome == "debito_bradesco"
    end
  
    def cartaocredito?
      self.nome == "cartaocredito"
    end
  
    def mercantil?
      self.nome == "boleto" || self.nome == "carne"
    end
  
    def self.CARNE
      where(:nome => "carne").first
    end
  
    def self.BOLETO
      where(:nome => "boleto").first
    end
  
    def self.CARTAO_CREDITO
      where(:nome => "cartaocredito").first
    end
  
    def self.DEBITO_BRADESCO
      where(:nome => "debito_bradesco").first
    end
  
    def self.DEBITO_BRASIL
      where(:nome => "debito_brasil").first
    end
  end
  
  def to_s
    self.descricao
  end
end
