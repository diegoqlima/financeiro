class AddDataFileToFinanceiroArquivos < ActiveRecord::Migration
  def change
    add_column :financeiro_arquivos, :data_file, :string
  end
end
