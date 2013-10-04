module Financeiro
  class Banco < ActiveRecord::Base
    
    def to_s
       "#{self.codigo} - #{self.nome}"
    end
  end
end
