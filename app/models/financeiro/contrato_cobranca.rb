module Financeiro
  class ContratoCobranca < ActiveRecord::Base
    belongs_to :conta
    
    scope :ativos, where(ativo: true)
  end
end
