class AddAssociationToEventoFinanceiros < ActiveRecord::Migration
  def change
    add_column :financeiro_evento_financeiros, :association_id, :integer
    add_column :financeiro_evento_financeiros, :association_class, :string
  end
end
