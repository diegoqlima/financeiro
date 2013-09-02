class AddPeriodoCobrancaToEventoFinanceiros < ActiveRecord::Migration
  def change
    add_column :financeiro_evento_financeiros, :periodo_cobranca_id, :integer
  end
end
