# encoding: UTF-8
module Financeiro
  module Bradesco
    module Critica
      STATE = {
        2 => "entrada_confirmada",
        3 => "entrada_rejeitada",
        6 => "liquidacao_normal",
        9 => "baixado_automatico_via_arquivo",
        10 => "baixado_conforme_instrucoes_da_agencia",
        11 => "em_ser_arquivo_de_titulos_pendentes",
        12 => "abatimento_concedido",
        13 => "abatimento_cancelado",
        14 => "vencimento_alterado",
        15 => "liquidacao_em_cartorio",
        16 => "titulo_pago_em_cheque_vinculado",
        17 => "liquidacao_apos_baixa_ou_titulo_nao_registrado",
        18 => "acerto_de_depositaria",
        19 => "confirmacao_receb_inst_de_protesto",
        20 => "confirmacao_recebimento_instrucao_sustacao_de_protesto",
        21 => "acerto_do_controle_do_participante",
        22 => "titulo_com_pagamento_cancelado",
        23 => "entrada_do_titulo_em_cartorio",
        24 => "entrada_rejeitada_por_cep_irregular",
        25 => "confirmacao_receb_inst_de_protesto_falimentar",
        27 => "baixa_rejeitada",
        28 => "debito_de_tarifas_custas",
        29 => "ocorrencias_do Sacado",
        30 => "alteracao_de_outros_dados_rejeitados",
        32 => "instrucao_rejeitada",
        33 => "confirmacao_pedido-alteracao_outros_dados",
        34 => "retirado_de_cartorio_e_manutencao_carteira",
        35 => "desagendamento_do_debito_automatico",
        40 => "estorno_de_pagamento",
        55 => "sustado_judicial",
        68 => "acerto_dos_dados_do_rateio_de_credito",
        69 => "cancelamento_dos_dados_do_rateio"
      }
      REGISTRO = [
        [:codigo_registro,1,:A],
        [:tipo_inscricao_empresa,2,:N,0],
        [:numero_inscricao_empresa,14,:N,0],
        [:zeros_1,3,:A],
        [:id_cliente_banco,17,:A],
        [:numero_controle_participante,25,:A],
        [:zeros_2,8,:N],
        [:id_titulo_banco_1,12,:A], # NOSSO NUEMRO
        [:uso_banco_1,10,:N,0],
        [:uso_banco_2,12,:A],
        [:indicador_rateio_credito,1,:A],
        [:zeros_3,2,:N,0],
        [:carteira,1,:N,0],
        [:id_ocorrencia,2,:N,0],
        [:data_ocorrencia_banco,6,:DDMMAA],
        [:numero_documento,10,:A],
        [:id_titulo_banco_2,20,:A], # NOSSO NUEMRO
        [:data_vencimento_titulo,6,:DDMMAA],
        [:valor_titulo,13,:N, 0],
        [:cod_banco_cobrador,3,:N, 0],
        [:agencia_cobrador,5,:N, 0],
        [:especie,2,:A],
        [:despesa_cobranca,13,:N,0],
        [:outras_despesas,13,:N,0],
        [:juros_atraso,13,:N,0],
        [:iof,13,:N,0],
        [:abatimento,13,:N,0],
        [:desconto,13,:N,0],
        [:valor_pago,13,:N,0],
        [:juros_mora,13,:N,0],
        [:outros_creditos,13,:N,0],
        [:brancos_1,2,:A],
        [:motivo_codigo_ocorrencia,2,:A],
        [:data_credito,6,:DDMMAA],
        [:origem_pagamento,3,:N,0],
        [:brancos_2,10,:A],
        [:codigo_banco_cheque,4,:N,0],
        [:motivo_rejeicao,10,:N,0],
        [:brancos_3,40,:A],
        [:numero_cartorio,2,:N,0],
        [:numero_protocolo,10,:A],
        [:brancos_4,14,:A],
        [:numero_sequencial_registro,6,:N,0]
      ]

      def pasta
        "bradesco/critica"
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
         erros = validar(arquivo)
         if(erros.size == 0)
           File.open(arquivo,'r').each_line do |line|
              if line =~ /^F/
                r = parse(line)
                p = Pagamento.find(r[:id_titulo_banco_1].to_i)
                puts "******************codigo:#{r[:codigo_retorno]}"
                p.state = r[:codigo_retorno].to_i
                p.sub_state = r[:codigo_retorno].to_i
                p.registros.create(:objeto => ActiveSupport::JSON.encode(r))
                p.save
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
        @errors = []
        i = 0;
        quantidade_registros = 2
        valor_total = 0
        aux_first_line = ""

        File.open(arquivo,'r').each_line do |line|
          if line.chomp.present? && !line.starts_with?("VALOR")
            # line.strip!
            tipo_registro = line[0...1]
            case tipo_registro
              when '0'
                aux_first_line = line
                # @errors.push({:i => i, :linha => line, :msg => "Header invalido" }) unless line =~ /A[0-9].{20}.{20}\d{3}.{20}\d{8}\d{6}\d{2}DEBITO AUTOMATICO.{52}/
              when '1'
                  r = parse(line)
                  puts "******************codigo:#{r[:codigo_retorno]}"
                  @errors.push({:i => i, :linha => line, :msg => "Pagamento não encontrado: #{r[:uso_empresa].to_i}"}) unless Pagamento.where("id=?",r[:uso_empresa].to_i).first
                  quantidade_registros+=1
                  valor_total += r[:valor_debito].to_i
              when '9'
                # @errors.push({:i => i, :linha => line, :msg => "Numero de registros no trailer não bate com o numero de registros do arquivo. Esperado:#{line[1..6].to_i}  - Encontrado:#{quantidade_registros}"}) if line[1..6].to_i != quantidade_registros
                # @errors.push({:i => i, :linha => line, :msg => "Valor total dos registros no trailer não bate com soma dos registros do arquivo. Esperado:#{line[7..23].to_i} - Encontrado: #{valor_total}"}) if line[7..23].to_i != valor_total
              else
                @errors.push({:i => 0, :linha => line, :msg => "Tipo de registro desconhecido" })
            end
            i+=1
          end
        end
        return @errors
      end
    end
  
    module Remessa
      CONVENIO = "01457"
      NOME_EMPRESA = "ASSOC.DIV. PROVIDEN"

      def form
        [
          [:mes_referencia, "Mes Referencia", :month_and_year],
          [:remessa, "Número da Remessa", :text]
        ]

      end

      def pasta
        "bradesco/remessa"
      end

      def gerar(params)
        @data_referencia = DateTime.new(params["mes_referencia(1i)"].to_i,
                                        params["mes_referencia(2i)"].to_i,1);
        @remessa = params['remessa'].to_i
        @registros = 0
        @valor_total = 0

        @buffer  = File.open(Rails.root.to_s + "/public/system/arquivos/#{pasta}/#{nome_arquivo(@remessa)}", "w:windows-1252:ascii")

        header
        body
        trailler
        @buffer.close


      end

      def nome_arquivo(remessa)
        "A#{DateTime.now.strftime('%Y%m%d')}.txt"
      end

      def lote
        ""
      end

      def header
        str = "A1#{CONVENIO.as_campo(20)}#{NOME_EMPRESA.as_campo(20)}"
        str += "237BANCO BRADESCO S.A  #{DateTime.now.strftime('%Y%m%d')}#{@remessa.as_campo(6,0)}04DEBITO AUTOMATICO"
        str += "".as_campo(52)
        str += "\r\n"
        @buffer.puts(str)
      end

      def body
        @registros = 2
        bradesco = MeioPagamento.where("nome = 'debito_bradesco'").first.id
        Pagamento.includes(:contribuicao => [:unidade,:pessoa,:meio_pagamento,:tipo_contribuicao]).
                  where("contribuicoes.meio_pagamento_id = #{bradesco} and data_referencia >= ? and data_referencia <= ? and pagamentos.state is null",
                        @data_referencia.beginning_of_month, @data_referencia.end_of_month).each do |pagamento|
          inject(pagamento)
          @buffer.puts(body_line(pagamento))
          @registros += 1
          @valor_total += (pagamento.valor * 100).to_i
        end
      end

      def body_line(obj)
        str  = "E#{obj.id_cliente_empresa.as_campo(25,0)}#{obj.agencia_debito.to_i.as_campo(4,0)}"
        str += "#{obj.id_cliente_banco.to_i.as_campo(8, 0).as_campo(14)}#{obj.data_vencimento.strftime('%Y%m%d')}"
        str += "#{obj.valor_debito.as_campo(13,2)}03#{obj.uso_empresa.to_s.as_campo(48)}#{''.as_campo(12)}#{''.as_campo(20)}#{obj.codigo_movimento}\r\n"
        # str += "#{obj.valor_debito.as_campo(13,2)}03#{''.as_campo(60)}#{''.as_campo(20)}#{obj.codigo_movimento}\r\n"
      end

      def trailler
        str = "Z#{@registros.as_campo(6,0)}#{@valor_total.as_campo(17,0)}#{''.as_campo(126)}\r\n"
        @buffer.puts(str)
      end

      #Adiciona o metodo to_arquivo ao objeto corrente
      def inject(obj)
        obj.instance_eval do
          def valor_debito
            self.valor
          end

          def data_vencimento
            if(self.contribuicao.dia_debito)
              Date.new(DateTime.now.year, DateTime.now.month, self.contribuicao.dia_debito.to_i)
            else
              self.data_vencimento
            end
          end

          def id_cliente_empresa
            self.contribuicao.pessoa.id
          end

          def id_cliente_banco
            self.contribuicao.conta.to_s + self.contribuicao.conta_digito.to_s
          end

          def uso_empresa
            self.id
          end

          def agencia_debito
            self.contribuicao.agencia.to_s
          end

          def codigo_movimento
            self.contribuicao.cancelado ? 1 : 0
          end
        end
      end
    end
  
  end
end