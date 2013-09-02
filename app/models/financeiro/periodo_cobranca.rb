# encoding: UTF-8
module Financeiro
  class PeriodoCobranca < ActiveRecord::Base
    belongs_to :tipo
  end
end
