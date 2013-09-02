class CreateFinanceiroEventoFinanceiros < ActiveRecord::Migration
  def change
    create_table :financeiro_evento_financeiros do |t|
      t.date :inicio
      t.date :fim
      t.float :valor
      t.references :tipo_evento_financeiro
      t.timestamps
      
      # add_index :financeiro_evento_financeiros, :tipo_evento_financeiro_id, :name => "tipo_evento_financeiro_id"
    end
  end
end
