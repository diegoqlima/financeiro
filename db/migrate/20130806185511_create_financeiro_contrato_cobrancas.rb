class CreateFinanceiroContratoCobrancas < ActiveRecord::Migration
  def change
    create_table :financeiro_contrato_cobrancas do |t|
      t.references :conta, index: true
      t.string :numero_contrato
      t.boolean :ativo, default: false
      t.string :carteira

      t.timestamps
    end
  end
end
