class CreateFinanceiroArquivos < ActiveRecord::Migration
  def change
    create_table :financeiro_arquivos do |t|
      t.references :tipo_arquivo, index: true
      t.string :parametros
      t.string :nome

      t.timestamps
    end
  end
end
