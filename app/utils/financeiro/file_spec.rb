# encoding: UTF-8
# -*- coding: utf-8 -*-
class TipoArquivo < ActiveRecord::Base
  #Carrega a especificação de como o arquivo deve ser gerado ou importado
  #para o sistema

  def load_spec
    self.extend eval(spec) if self.spec
  end
  
end

