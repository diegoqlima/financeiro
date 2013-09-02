# encoding: UTF-8
class CreateFinanceiroPeriodoCobrancas < ActiveRecord::Migration
  def change
    create_table :financeiro_periodo_cobrancas do |t|
      t.string :descricao
      t.string :meses

      t.timestamps
    end
    
    Financeiro::PeriodoCobranca.create(descricao: "Taxa Única", meses: 0)
    Financeiro::PeriodoCobranca.create(descricao: "Mensal", meses: 1)
    Financeiro::PeriodoCobranca.create(descricao: "Trimestral", meses: 3)
    Financeiro::PeriodoCobranca.create(descricao: "Semestral", meses: 6)
    Financeiro::PeriodoCobranca.create(descricao: "Anual", meses: 12)
  end
end
