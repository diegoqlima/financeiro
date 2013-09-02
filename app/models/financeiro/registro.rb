module Financeiro
  class Registro < ActiveRecord::Base
    belongs_to :pagamento
  end
end
