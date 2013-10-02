class CreateFinanceiroFinanceiroConfiguracoes < ActiveRecord::Migration
  def change
    create_table :financeiro_financeiro_configuracoes do |t|
      t.string :email_pagseguro
      t.string :token_pagseguro
      t.string :notification_url
      t.string :redirect_url

      t.timestamps
    end
  end
end
