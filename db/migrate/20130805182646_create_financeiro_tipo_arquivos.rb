# encoding: UTF-8
class CreateFinanceiroTipoArquivos < ActiveRecord::Migration
  def change
    create_table :financeiro_tipo_arquivos do |t|
      t.string :descricao
      t.references :meio_pagamento, index: true
      t.boolean :entrada
      t.string :spec
      t.integer :numero_remessa, :integer, :default => 0

      t.timestamps
    end
    
    Financeiro::TipoArquivo.create(:descricao => "Remessa Bradesco",
                       :meio_pagamento_id => Financeiro::MeioPagamento.DEBITO_BRADESCO.id, 
                       :entrada => false, 
                       :spec => 'Financeiro::Bradesco::Remessa');

    Financeiro::TipoArquivo.create(:descricao => "Crítica Bradesco",
                       :meio_pagamento_id => Financeiro::MeioPagamento.DEBITO_BRADESCO.id, 
                       :entrada => true, 
                       :spec => 'Financeiro::Bradesco::Critica');
                       
    Financeiro::TipoArquivo.create(:descricao => "Crítica Mercantil", 
                       :meio_pagamento_id => Financeiro::MeioPagamento.BOLETO.id,
                       :entrada => true,
                       :spec => 'Financeiro::BancoMercantil::Retorno');
                      
    Financeiro::TipoArquivo.create(:descricao => "Remessa Mercantil", 
                      :meio_pagamento_id => Financeiro::MeioPagamento.BOLETO.id,
                      :entrada => false,
                      :spec => 'Financeiro::BancoMercantil::Remessa');
                      
    Financeiro::TipoArquivo.create(:descricao => "Remessa Banco Brasil",
                       :meio_pagamento_id => Financeiro::MeioPagamento.DEBITO_BRASIL.id, 
                       :entrada => false, 
                       :spec => 'Financeiro::BancoBrasil::Remessa');

    Financeiro::TipoArquivo.create(:descricao => "Crítica Banco Brasil",
                       :meio_pagamento_id => Financeiro::MeioPagamento.DEBITO_BRASIL.id, 
                       :entrada => true, 
                       :spec => 'Financeiro::BancoBrasil::Critica');
    
  end
end
