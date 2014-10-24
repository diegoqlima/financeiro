module Financeiro
  class TipoArquivo < ActiveRecord::Base
    belongs_to :meio_pagamento
    
    #Carrega a especificação de como o arquivo deve ser gerado ou importado
    #para o sistema
    def load_spec
      self.extend eval(spec) if self.spec
    end
  end
end
