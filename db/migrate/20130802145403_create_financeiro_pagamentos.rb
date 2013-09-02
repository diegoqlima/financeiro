class CreateFinanceiroPagamentos < ActiveRecord::Migration
  def change
    create_table :financeiro_pagamentos do |t|
      t.float :valor
      t.string :state
      t.string :codigo_critica
      t.string :sub_codigo_critica
      t.date :data_vencimento
      t.date :data_pagamento
      t.references :evento_financeiro, index: true

      t.timestamps
    end
  end
end
