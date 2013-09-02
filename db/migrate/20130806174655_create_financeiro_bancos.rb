class CreateFinanceiroBancos < ActiveRecord::Migration
  def change
    create_table :financeiro_bancos do |t|
      t.string :codigo
      t.string :nome

      t.timestamps
    end
  end
end
