module Financeiro
  class ContratoCobranca < ActiveRecord::Base
    belongs_to :conta
  end
end
