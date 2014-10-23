class AddCodigoEmpresaToFinanceiroBancos < ActiveRecord::Migration
  def change
    add_column :financeiro_bancos, :codigo_empresa, :string
  end
end
