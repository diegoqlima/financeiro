class CreateFinanceiroRegistros < ActiveRecord::Migration
  def change
    create_table :financeiro_registros do |t|
      t.text :objeto
      t.references :pagamento, index: true

      t.timestamps
    end
  end
end
