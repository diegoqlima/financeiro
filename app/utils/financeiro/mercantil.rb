# encoding: UTF-8
module Financeiro
module BancoMercantil
  
  CAMPO_LIVRE_20 = "".as_campo(20)
  BRANCO = ""
  MOEDA = "REAL".as_campo(10)
  CNPJ = "00981069000143"
  
  module Retorno
    STATE = {
      2 => 'entrada_confirmada',
      3 => 'entrada_rejeitada',
      4 => 'transferencia_contrato',
      6 => 'liquidado',
      9 => 'baixa_automatica',
      10 => 'baixa_pedido_cedente',
      12 => 'abatimento_concedido',
      13 => 'abatimento_cancelado',
      14 => 'alteracao_de_vencimento',
      15 => 'liquidado_cartorio',
      16 => 'liquidado_cheque_compensar',
      19 => 'alteracao_instrucao_protesto',
      22 => 'alteracao_seu_numero',
      23 => 'liquidado_debito_conta',
      24 => 'liquidado_banco_correspondente',
      31 => 'baixa_franco_pagamento',
      55 => 'instrucao_codificada',
      56 => 'sustar_protesto_manter_carteira',
      65 => 'emissao_segunda_via_aviso',
      67 => 'nao_conceder_juros_fora_prazo',
      83 => 'cobranca_automatica_tarifas',
      84 => 'protestar_sem_mais_consultas',
      85 => 'baixa_titulo_protestado'
    }
    REG_FILE_STATE = {
      1 => 'codigo_cliente_invalido',
      2 => 'nosso_numero_invalido',
      3 => 'cnpj_cpf_cedente_invalido',
      4 => 'quantidade_moeda_invaldio',
      5 => 'codigo_operacao_invalido_ou_divergente_contrato',
      6 => 'codigo_movimento_invalido',
      7 => 'data_vencimento_invalida',
      8 => 'valor_titulo_invalido',
      9 => 'codigo_especie_invalido',
      10 => 'data_emissao_invalida_maior_movimento',
      11 => 'instrucao_invalida',
      12 => 'juros_invalido',
      13 => 'desconto_ate_invalido_maior_menor_emissao',
      14 => 'valor_desconto_invalido_maior_valor_titulo',
      15 => 'valor_iof_invalido_maior_valor_titulo',
      16 => 'valor_abatimento_maior_valor_titulo',
      17 => 'nome_sacado_invalido',
      18 => 'endereco_sacado_invalido',
      19 => 'cep_sacado_invalido',
      20 => 'codigo_moeda_invalido',
      21 => 'seu_numero_invalido',
      22 => 'titulo_ja_cadastrado',
      23 => 'titulo_ja_baixado',
      24 => 'codigo_moeda_invalido_para_data_emissao',
      25 => 'instrucao_nao_acatada_pela_agencia',
      40 => 'agencia_contrato_cnpj_invalido',
      41 => 'tipo_formulario_contrato_invalido',
      42 => 'carteira_invalida',
      43 => 'registro_sacado_invalido',
      44 => 'numero_parcela_carne_invalido',
      45 => 'intervalo_carne_invalido',
      46 => 'erro_cpf_cnpj_sacado_invalido',
      47 => 'erro_quantidade_aluno_informados',
      48 => 'nome_socio_nao_informado',
      49 => 'numero_socio_sem_zeros',
      50 => 'cep_nao_numericos',
      51 => 'numero_documento_invalido',
    }
    REGISTRO = [
      [:codigo_registro,1,:N,0],
      [:codigo_inscricao,2,:N,0], # 01 CPF - 02 CNPJ
      [:numero_inscricao,14,:N,0],
      [:agencia,4,:N,0],
      [:numero_conta,7,:N,0],
      [:numero_contrato,9,:N,0],
      [:uso_da_empresa,25,:A],
      [:nosso_numero_agencia,4,:N,0],
      [:nosso_numero,10,:N,0],
      [:dv_nosso_numero,1,:N,0],
      [:filler1,30,:A],
      [:carteira,1,:N,0],
      [:codigo_ocorrencia,2,:N,0],
      [:data_pagamento,6,:DDMMAA],
      [:seu_numero,10,:A],
      [:filler2,20,:A],
      [:vencimento,6,:N,0],
      [:valor_titulo,13,:N,2],
      [:banco_cobrador,3,:N,0], # Igual a 389
      [:agencia_cobradora,5,:N,0],
      [:codigo_especie,2,:N,0],
      [:tarifa_cobranca,13,:N,2],
      [:outras_despesas,13,:N,0],
      [:juros,13,:N,2],
      [:iof,13,:N,2],
      [:abatimento,13,:N,2],
      [:valor_desconto,13,:N,2],
      [:valor_pago,13,:N,2],
      [:juros_de_mora,13,:N,2],
      [:outros_creditos,13,:N,2],
      [:filler3,3,:A],
      [:data_de_credito,6,:DDMMAA],
      [:indicador_mora,1,:A],
      [:taxa_de_permanencia,12,:A],
      [:data_limite,6,:DDMMAA],
      [:desconto_limite,13,:N,2],
      [:primeira_instrucao,2,:N,0],
      [:segunda_instrucao,2,:N,0],
      [:quantidade_moeda,15,:N,0],
      [:filler4,25,:A],
      [:codigo_rejeicao,10,:N,0],
      [:filler5,4,:A],
      [:protesto,2,:N,0],
      [:codigo_moeda,1,:N,0],
      [:numero_sequencial,6,:N,0],
    ]

    def pasta
      "mercantil/critica"
    end

    def nome
    end

    def valida_nome_arquivo(nome)
      # "Nome do arquivo inválido" unless nome =~ /TCO1\.PSFD\.MOVCDR\.T00238\.O00017\.D[0-9]{6,6}\.txt/
    end

    def parse(linha)
      h = {}
      p = 0
      REGISTRO.each do |r|
        h[r[0]] = linha[p...(p + r[1])]
        p += r[1]
      end
      return h
    end

    def processar(arquivo)
      total_processado = 0
      total_diff = 0
      erros = validar(arquivo)
      if(erros.size == 0)
         File.open(arquivo,'r').each_line do |line|
            if line =~ /^1/
              r = parse(line)
              p = Pagamento.find_by_id(r[:nosso_numero].to_i)
              if(p.nil?)
                total_diff += 1
                next
              end
              logger.info "******************codigo:#{r[:codigo_ocorrencia]}"
              p.state = r[:codigo_ocorrencia].to_i
              p.sub_state = r[:codigo_ocorrencia].to_i
              p.registros.create(:objeto => ActiveSupport::JSON.encode(r))
              if(r[:valor_pago].present? && r[:valor_pago].to_f > 0)
                valor = r[:valor_pago].slice(0,11).to_i
                centavos = r[:valor_pago].slice(11,12)
                total = valor.to_s+"."+centavos.to_s
                # p.valor = total.to_f
                p.valor_pg = total.to_f
              end
              # logger.info ">>>>>>>>>>>>>>>>>>DATA_PAGAMENTO #{r[:data_pagamento]}"
              p.data_pagamento = Date.strptime("#{r[:data_pagamento]}","%d%m%y")
              p.save
              total_processado += 1
            end
          end
      end
      return erros
    end

    def mensagem_processamento(arquivo)
       total_processado = 0
       total_diff = 0

         File.open(arquivo,'r').each_line do |line|
            if line =~ /^1/
              r = parse(line)
              p = Pagamento.find_by_id(r[:nosso_numero].to_i)
              if(p.nil?)
                total_diff += 1
                next
              end
              total_processado += 1
            end
          end
          # Quantidade de Pagamentos Processados:
          # Quantidade de Pagamentos Diff:
          # Total de Pagamentos Processados:

       return "Qtde. Pagamentos Processados: #{total_processado}_Qtde. Pagamentos Diff: #{total_diff}"
    end

    def validar(arquivo)
      @buffer_diff  = File.open(Rails.root.to_s + "/public/system/arquivos/#{pasta}/DIF_#{arquivo.split("/").last}", "w")
      @errors = []
      i = 0;
      quantidade_registros = 0
      valor_total = 0
      diff = 0
      aux_first_line = ""
      aux_last_line = ""

      File.open(arquivo,'r').each_line do |line|
        line.strip!
        tipo_registro = line[0...1]
        case tipo_registro
          when '0'
            aux_first_line = line
            # @errors.push({:i => i, :linha => line, :msg => "Header invalido" }) unless line =~ /^1[0-9]{8}0023800017/
          when '1'
              r = parse(line)
              puts r.inspect
              unless (Pagamento.where("id=?",r[:nosso_numero].to_i).first)
                @buffer_diff.puts(aux_first_line) if(diff == 0)
                diff += 1
                @buffer_diff.puts(line)
              end
              # @errors.push({:i => i, :linha => line, :msg => "Pagamento não encontrado: #{r[:nosso_numero]}"}) unless Pagamento.where("id=?",r[:nosso_numero].to_i).first
              quantidade_registros+=1
              valor_total += r[:valor_pago].to_i
          when '9'
            aux_last_line = line
            @errors.push({:i => i, :linha => line, :msg => "Numero de registros no trailer não bate com o numero de registros do arquivo. Esperado:#{line[17..24].to_i}  - Encontrado:#{quantidade_registros}"}) if line[17..24].to_i != quantidade_registros
            # @errors.push({:i => i, :linha => line, :msg => "Valor total dos registros no trailer não bate com soma dos registros do arquivo. Esperado:#{line[25..38].to_i} - Encontrado: #{valor_total}"}) if line[25..38].to_i != valor_total
          else
            @errors.push({:i => 0, :linha => line, :msg => "Tipo de registro desconhecido" })
        end
        i+=1
      end
      @buffer_diff.puts(aux_last_line)
      @buffer_diff.close
      if(diff == 0)
        File.delete(Rails.root.to_s + "/public/system/arquivos/#{pasta}/DIF_#{arquivo.split("/").last}")
      end
      return @errors
    end
  end
  
  module Remessa
    def form
      [
        [:inicio, "Inicio", :date],
        [:fim, "Fim", :date],
        # [:mes_referencia, "Mes Referencia", :month_and_year],
        [:contrato_cobranca, "Contrato Cedente", :select, ContratoCobranca.buscar_contas_cedentes.collect{|c| [c.formatted_name, c.id]}, ["ContratoCobranca", "formatted_name"]  ]
      ]

    end

    def pasta
      "mercantil/remessa"
    end

    def gerar(params)
      @inicio = DateTime.new(params["inicio(1i)"].to_i, params["inicio(2i)"].to_i, params["inicio(3i)"].to_i);
      @fim = DateTime.new(params["fim(1i)"].to_i, params["fim(2i)"].to_i, params["fim(3i)"].to_i);

      # @data_referencia = DateTime.new(params["mes_referencia(1i)"].to_i, params["mes_referencia(2i)"].to_i,1);
      @remessa = params['remessa'].to_i
      @contrato_cobranca = params['contrato_cobranca']
      @registros = 0
      @valor_total = 0

      @buffer  = File.open(Rails.root.to_s + "/public/system/arquivos/#{pasta}/#{nome_arquivo(@remessa)}", "w:windows-1252:ascii")

      header
      body
      trailler
      @buffer.close

    end

    def nome_arquivo(remessa)
      "2800GERAL.#{DateTime.now.strftime('%Y%m%d')}-#{remessa}.txt"
    end

    def lote
      ""
    end

    def header
      ""
    end

    def body
      boleto = MeioPagamento.where("nome = 'boleto'").first.id
      pesquisa_contrato_cobranca = @contrato_cobranca.present? ? " and contribuicoes.contrato_cobranca_id = #{@contrato_cobranca}" : ""
      Pagamento.includes(:contribuicao => [:unidade,:pessoa,:meio_pagamento,:tipo_contribuicao]).
                where("contribuicoes.meio_pagamento_id = #{boleto} #{pesquisa_contrato_cobranca} and data_referencia >= ? and data_referencia <= ? and pagamentos.state is null",
                      @inicio.beginning_of_day, @fim.end_of_day).each do |pagamento|
        inject(pagamento)
        @buffer.puts(body_line(pagamento))
        @registros += 1
        @valor_total += (pagamento.valor * 100).to_i
      end
    end

    def body_line(obj)
      str  = "#{obj.cedente.as_campo(40)}#{obj.dados_sacado}"
      str += "#{DateTime.now.strftime('%d%m%Y')}#{obj.vencimento.strftime('%d%m%Y')}"
      str += "#{obj.nosso_numero}#{obj.digito_nosso_numero}"
      str += "#{obj.valor_documento.as_campo(13,2)}#{obj.numero_carteira}"
      str += "#{MOEDA}#{obj.quantidade_moeda}"
      str += "#{obj.especie_documento}#{obj.aceite}"
      str += "#{obj.instrucoes_bancarias}"
      str += "#{obj.instrucoes_sacado.as_campo(120)}"
      str += "#{obj.mensagem_sacado.as_campo}"
      str += "#{obj.agencia.as_campo(4)}#{obj.codigo_cedente.as_campo(9)}"
      str += "#{obj.cnpj_cedente.as_campo(14)}#{obj.indicador_ano.as_campo(1)}"
      str += "#{obj.instrucao_codificada.as_campo(4)}#{BRANCO.as_campo(7)}\r\n"
    end

    def trailler
      ""
    end


    #Adiciona o metodo to_arquivo ao objeto corrente
    def inject(obj)
      obj.instance_eval do

        def cedente
          self.contribuicao.instituicao.nome.to_s.remover_acentos
        end

        def dados_sacado
          dados = ""
          cidade_uf = self.contribuicao.pessoa.cidade ? self.contribuicao.pessoa.cidade.nome.as_campo(15) : "".as_campo(15)
          cidade_uf += self.contribuicao.pessoa.cidade ? self.contribuicao.pessoa.cidade.estado.sigla.as_campo(2)  : "".as_campo(2)
          # NOME - 35
          dados += self.contribuicao.pessoa.nome ? self.contribuicao.pessoa.nome.as_campo(35) : "".as_campo(35)
          # ENDERECO - 40
          dados += self.contribuicao.pessoa.endereco_minimo.as_campo(40)
          if self.contribuicao.pessoa.endereco.blank?
            # BAIRRO - 12
            dados += self.contribuicao.pessoa.endereco_cobranca_bairro ? self.contribuicao.pessoa.endereco_cobranca_bairro.as_campo(12) : "".as_campo(12)
            # CIDADE - 15 e  UF - 2
            dados += cidade_uf
            # CEP - 8
            dados += self.contribuicao.pessoa.endereco_cobranca_cep ? self.contribuicao.pessoa.endereco_cobranca_cep.as_campo(8) : "".as_campo(8)
          else
            # BAIRRO - 12
            dados += self.contribuicao.pessoa.bairro ? self.contribuicao.pessoa.bairro.as_campo(12) : "".as_campo(12)
            # CIDADE - 15 e  UF - 2
            dados += cidade_uf
            # CEP - 8
            dados += self.contribuicao.pessoa.cep ? self.contribuicao.pessoa.cep.as_campo(8) : "".as_campo(8)
          end
          # REGISTRO - 6 + CAMPO LIVRE - 20
          dados += 0.as_campo(6,0) + CAMPO_LIVRE_20 + " ".as_campo(5)
          dados += self.contribuicao.pessoa.cpf ? self.contribuicao.pessoa.cpf.to_i.as_campo(15,0) : 0.as_campo(15,0)
          dados += " "
          dados.remover_acentos
        end

        def vencimento
          self.data_referencia
        end

        # Formacao do nosso numero
        # {XXXXXXXXXX}-{D}
        # {XXXXXXXXXX} -> ID DA CONTRIBUICAO
        # {D} -> Digito verificador mod11(Codigo da agencia cedente + ID DA CONTRIBUICAO)
        def nosso_numero
          self.id.as_campo(10,0).to_s
        end

        def digito_nosso_numero
          (agencia.as_campo(4).to_s + nosso_numero).modulo11_mercantil { |valor| [0,1].include?(valor) ? 0 : (11 - valor) }
        end

        def valor_documento
          self.valor
        end

        def numero_carteira
          "06"
        end

        def quantidade_moeda
          "000000000000000"
        end

        def especie_documento
          "OU"
        end

        def aceite
          "N"
        end

        def instrucoes_bancarias
          instrucoes = ""
          if self.contribuicao.contrato_cobranca.conta.instrucoes_bancarias
            (0..5).each do |ix|
              instrucoes += (self.contribuicao.contrato_cobranca.conta.instrucoes_bancarias.split(Conta::QUEBRA_INSTRUCAO_BANCARIA)[ix]).to_s.as_campo(70)
            end
          end
          instrucoes.remover_acentos
        end

        def instrucoes_sacado
          instrucoes = ""
          if self.contribuicao.contrato_cobranca.conta.instrucoes_bancarias
            (0..2).each do |ix|
              instrucoes += (self.contribuicao.contrato_cobranca.conta.instrucoes_sacado.split(Conta::QUEBRA_INSTRUCAO_SACADO)[ix]).to_s.as_campo(40)
            end
          end
          instrucoes.remover_acentos
        end

        def mensagem_sacado
          # mensagem = "Pagamento referente a manutencao de menores carentes assistidas pela Cidade dos Meninos Sao Vicente de Paulo.".as_campo(130)
          mensagem = "".as_campo(130)
          # mensagem += "visite nosso site:www.redesolidariedade.org.br ou (31)3228-9236".as_campo(130)
          mensagem += "".as_campo(130)
          # mensagem += "Ser anjo e voce ser capaz de iluminar no momento em que o outro e trevas!".as_campo(130)
          mensagem += "".as_campo(130)
          mensagem += "".as_campo(1560)
        end

        def agencia
          self.contribuicao.contrato_cobranca ? self.contribuicao.contrato_cobranca.conta.agencia.to_f.as_campo(4,0) : 0.as_campo(4,0)
        end

        def codigo_cedente
          self.contribuicao.contrato_cobranca ? self.contribuicao.contrato_cobranca.numero_contrato.to_f.as_campo(9,0) : 0.as_campo(9,0)
        end

        def cnpj_cedente
          self.contribuicao.contrato_cobranca.conta.cnpj.gsub(/\.|\/|\-|\s/,'').as_campo(14)
        end

        def indicador_ano
          "S"
        end

        def instrucao_codificada
          "0000"
        end

      end
    end

  end
  end
end
