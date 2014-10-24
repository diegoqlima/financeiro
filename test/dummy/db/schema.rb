# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141024123303) do

  create_table "financeiro_arquivos", force: true do |t|
    t.integer  "tipo_arquivo_id"
    t.string   "parametros"
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file"
  end

  add_index "financeiro_arquivos", ["tipo_arquivo_id"], name: "index_financeiro_arquivos_on_tipo_arquivo_id"

  create_table "financeiro_bancos", force: true do |t|
    t.string   "codigo"
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigo_empresa"
  end

  create_table "financeiro_contas", force: true do |t|
    t.integer  "banco_id"
    t.string   "agencia"
    t.string   "numero_conta"
    t.string   "tipo_conta"
    t.string   "titular"
    t.string   "cnpj"
    t.string   "instrucoes_bancarias", limit: 438
    t.string   "instrucoes_sacado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "local_pagamento"
  end

  add_index "financeiro_contas", ["banco_id"], name: "index_financeiro_contas_on_banco_id"

  create_table "financeiro_contrato_cobrancas", force: true do |t|
    t.integer  "conta_id"
    t.string   "numero_contrato"
    t.boolean  "ativo",           default: false
    t.string   "carteira"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "financeiro_contrato_cobrancas", ["conta_id"], name: "index_financeiro_contrato_cobrancas_on_conta_id"

  create_table "financeiro_evento_financeiros", force: true do |t|
    t.date     "inicio"
    t.date     "fim"
    t.float    "valor"
    t.integer  "tipo_evento_financeiro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meio_pagamento_id"
    t.integer  "periodo_cobranca_id"
    t.integer  "association_id"
    t.string   "association_class"
  end

  create_table "financeiro_financeiro_configuracoes", force: true do |t|
    t.string   "email_pagseguro"
    t.string   "token_pagseguro"
    t.string   "notification_url"
    t.string   "redirect_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financeiro_meio_pagamentos", force: true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financeiro_pagamentos", force: true do |t|
    t.float    "valor"
    t.string   "state"
    t.string   "codigo_critica"
    t.string   "sub_codigo_critica"
    t.date     "data_vencimento"
    t.date     "data_pagamento"
    t.integer  "evento_financeiro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "financeiro_pagamentos", ["evento_financeiro_id"], name: "index_financeiro_pagamentos_on_evento_financeiro_id"

  create_table "financeiro_periodo_cobrancas", force: true do |t|
    t.string   "descricao"
    t.string   "meses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financeiro_registros", force: true do |t|
    t.text     "objeto"
    t.integer  "pagamento_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "financeiro_registros", ["pagamento_id"], name: "index_financeiro_registros_on_pagamento_id"

  create_table "financeiro_tipo_arquivos", force: true do |t|
    t.string   "descricao"
    t.integer  "meio_pagamento_id"
    t.boolean  "entrada"
    t.string   "spec"
    t.integer  "numero_remessa",    default: 0
    t.integer  "integer",           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "financeiro_tipo_arquivos", ["meio_pagamento_id"], name: "index_financeiro_tipo_arquivos_on_meio_pagamento_id"

  create_table "financeiro_tipo_evento_financeiros", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
