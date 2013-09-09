# encoding: UTF-8
module Financeiro
  class PeriodoCobranca < ActiveRecord::Base
    belongs_to :tipo
    
    def to_s
      self.descricao
    end
  end
end
