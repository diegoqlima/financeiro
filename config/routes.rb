Financeiro::Engine.routes.draw do
  resources :financeiro_configuracoes

  resources :arquivos

  resources :periodo_cobrancas

  resources :contrato_cobrancas

  resources :conta

  resources :bancos

  resources :tipo_arquivos

  resources :meio_pagamentos

  resources :pagamentos

  resources :evento_financeiros

  resources :tipo_evento_financeiros
  
  resources :checkout do 
    member do 
      get "pagar"
    end
  end
end
