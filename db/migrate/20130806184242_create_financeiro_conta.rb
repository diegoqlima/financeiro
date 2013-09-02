class CreateFinanceiroConta < ActiveRecord::Migration
  def change
    create_table :financeiro_conta do |t|
      t.references :banco, index: true
      t.string :agencia
      t.string :numero_conta
      t.string :tipo_conta
      t.string :titular
      t.string :cnpj
      t.string :instrucoes_bancarias, :limit => 438
      t.string :instrucoes_sacado

      t.timestamps
    end
  end
end
