module Financeiro
  class Conta < ActiveRecord::Base
    belongs_to :banco
  end
end
