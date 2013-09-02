Financeiro::Engine.routes.draw do
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
end
