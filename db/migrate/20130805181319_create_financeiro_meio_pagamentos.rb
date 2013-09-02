# encoding: UTF-8
class CreateFinanceiroMeioPagamentos < ActiveRecord::Migration
  def change
    create_table :financeiro_meio_pagamentos do |t|
      t.string :nome
      t.string :descricao

      t.timestamps
    end
    
    Financeiro::MeioPagamento.create(:nome => 'carne' , :descricao => "Carnê de contribuição")
    Financeiro::MeioPagamento.create(:nome => 'boleto' , :descricao => "Boleto bancário")
    Financeiro::MeioPagamento.create(:nome => 'cartaocredito' , :descricao => "Debito em no cartao de crédito")
    Financeiro::MeioPagamento.create(:nome => 'debito_bradesco' , :descricao => "Debito em conta corrente Bradesco")
    Financeiro::MeioPagamento.create(:nome => 'debito_brasil' , :descricao => "Debito em conta corrente Banco Brasil")
    
  end
end
