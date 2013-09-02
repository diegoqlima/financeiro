module Financeiro
  class TipoEventoFinanceiro < ActiveRecord::Base
    
    def to_s
      self.descricao
    end
  end
end
