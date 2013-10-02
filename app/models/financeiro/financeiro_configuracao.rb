module Financeiro
  class FinanceiroConfiguracao < ActiveRecord::Base
    
    validates_presence_of :email_pagseguro
    validates_presence_of :token_pagseguro
    validates_presence_of :notification_url
    validates_presence_of :redirect_url
    
  end
end
