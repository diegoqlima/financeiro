class AddInstrucoesBancariasToFinanceiroTipoEventoFinanceiro < ActiveRecord::Migration
  def change
    add_column :financeiro_tipo_evento_financeiros, :instrucao_1, :string
    add_column :financeiro_tipo_evento_financeiros, :instrucao_2, :string
    add_column :financeiro_tipo_evento_financeiros, :instrucao_3, :string
    add_column :financeiro_tipo_evento_financeiros, :instrucao_4, :string
    add_column :financeiro_tipo_evento_financeiros, :instrucao_5, :string
  end
end
