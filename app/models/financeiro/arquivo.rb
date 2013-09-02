module Financeiro
  class Arquivo < ActiveRecord::Base
    belongs_to :tipo_arquivo
    validates_presence_of :nome
    validates_presence_of :tipo_arquivo
  end
end
