Rails.application.routes.draw do

  resources :periodo_cobrancas

  mount Financeiro::Engine => "/financeiro"
end
