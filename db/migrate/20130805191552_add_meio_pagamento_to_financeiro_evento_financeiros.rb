class AddMeioPagamentoToFinanceiroEventoFinanceiros < ActiveRecord::Migration
  def change
    add_column :financeiro_evento_financeiros, :meio_pagamento_id, :integer
  end
end
