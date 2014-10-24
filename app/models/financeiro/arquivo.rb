module Financeiro
  class Arquivo < ActiveRecord::Base
    belongs_to :tipo_arquivo
    validates_presence_of :tipo_arquivo
    validates_presence_of :data_file
    
    mount_uploader :data_file, Financeiro::FileUploader
    
    def valida_arquivo
      ta = Financeiro::TipoArquivo.find(self.tipo_arquivo_id)
      ta.load_spec

      if ta.entrada
        if self.tipo_arquivo_id.blank?
          self.errors.add(:base, "Informe o tipo de arquivo.")
        elsif !self.data_file.present?
          self.errors.add(:base, "Informe o arquivo.")
        else
          ta = Financeiro::TipoArquivo.find(self.tipo_arquivo_id)
          ta.load_spec
          e = ta.valida_nome_arquivo(upload['datafile'].original_filename)
          self.errors[:base].push(e) if e
        end
      end
    end
  end
end
