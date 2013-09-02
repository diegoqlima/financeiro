module Financeiro
  class TipoArquivo < ActiveRecord::Base
    belongs_to :meio_pagamento
  end
end
