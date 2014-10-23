class AddLocalPagamentoToFinanceiroContas < ActiveRecord::Migration
  def change
    add_column :financeiro_contas, :local_pagamento, :string
  end
end
