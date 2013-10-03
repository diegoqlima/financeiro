class RenameContaToContas < ActiveRecord::Migration
  def change
    rename_table :financeiro_conta, :financeiro_contas
  end
end
