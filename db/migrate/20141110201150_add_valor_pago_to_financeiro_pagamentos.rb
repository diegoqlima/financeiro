class AddValorPagoToFinanceiroPagamentos < ActiveRecord::Migration
  def change
    add_column :financeiro_pagamentos, :valor_pago, :float
  end
end
