class CreateFinanceiroTipoEventoFinanceiros < ActiveRecord::Migration
  def change
    create_table :financeiro_tipo_evento_financeiros do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
