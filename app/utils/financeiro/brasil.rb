# encoding: UTF-8
module Financeiro
  module BancoBrasil
    module Critica
      STATE = {
        0 => 'debito_efetuado',
        1 => 'insuficiencia_fundos',
        2 => 'conta_corrente_nao_cadastrada',
        4 => 'outras_restricoes',
        10 => 'agencia_em_encerramento',
        12 => 'valor_invalido',
        13 => 'data_lancamento_invalida',
        14 => 'agencia_invalida',
        15 => 'dac_conta_invalida',
        18 => 'data_debito_anterior_processamento',
        30 => 'sem_contrato_debito_automatico',
        96 => 'manutencao_do_cadastro',
        97 => 'cancelamento_nao_encontrado',
        98 => 'cancelamento_nao_efetuado',
        99 => 'cancelado_conforme_soicitacao'
      }
      REGISTRO = [
        [:codigo_registro,1,:A],
        [:id_cliente_empresa,25,:A],
        [:agencia,4,:A],
        [:id_cliente_banco,14,:A],
        [:data_vencimento_debito,8,:AAAAMMDD],
        [:valor_debito,15,:N,2],          
        [:codigo_retorno,2,:A],
        [:uso_empresa,60,:A],
        [:filler,20,:A],
        [:codigo_movimento,1,:N, 0]
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
                p = Pagamento.find(r[:uso_empresa].to_i)
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
      
      def validar(arquivo)          
        @errors = []
        i = 0;
        quantidade_registros = 2
        valor_total = 0

        File.open(arquivo,'r').each_line do |line|
          # line.strip!
          tipo_registro = line[0...1]
          case tipo_registro
            when 'A' 
              @errors.push({:i => i, :linha => line, :msg => "Header invalido" }) unless line =~ /A[0-9].{20}.{20}\d{3}.{20}\d{8}\d{6}\d{2}DEBITO AUTOMATICO.{52}/
            when 'F' 
                r = parse(line)
                @errors.push({:i => i, :linha => line, :msg => "Pagamento não encontrado: #{r[:uso_do_terceiro]}"}) unless Pagamento.where("id=?",r[:uso_do_terceiro].to_i).first
                quantidade_registros+=1
                valor_total += r[:valor_debito].to_i
            when 'Z'
              @errors.push({:i => i, :linha => line, :msg => "Numero de registros no trailer não bate com o numero de registros do arquivo. Esperado:#{line[1..6].to_i}  - Encontrado:#{quantidade_registros}"}) if line[1..6].to_i != quantidade_registros
              @errors.push({:i => i, :linha => line, :msg => "Valor total dos registros no trailer não bate com soma dos registros do arquivo. Esperado:#{line[7..23].to_i} - Encontrado: #{valor_total}"}) if line[7..23].to_i != valor_total
            else
              @errors.push({:i => 0, :linha => line, :msg => "Tipo de registro desconhecido" })               
          end
          i+=1            
        end
        return @errors
      end
    end
  end
  
  module Remessa
    BRANCO = ""
    CONVENIO = "15118"
    NOME_EMPRESA = "ASSOC.DIV. PROVIDEN"      
  
    def form
      [
        [:mes_referencia, "Mes Referencia", :month_and_year],
        [:remessa, "Número da Remessa", :text]
      ]

    end

    def pasta
      "bancobrasil/remessa"
    end

    def gerar(params)
      @data_referencia = DateTime.new(params["mes_referencia(1i)"].to_i, 
                                      params["mes_referencia(2i)"].to_i,1);
      @remessa = params['remessa'].to_i                                 
      @registros = 0
      @valor_total = 0

      @buffer  = File.open(Rails.root.to_s + "/public/system/arquivos/#{pasta}/#{nome_arquivo(@remessa)}", "w")

      header
      body
      trailler
      @buffer.close
    end

    def nome_arquivo(remessa)
      "DBT_#{DateTime.now.strftime('%Y%m%d')}"
    end

    def lote
      ""
    end

    def header
      str = "A1#{CONVENIO.as_campo(20)}#{NOME_EMPRESA.as_campo(20)}"
      str += "001BANCO DO BRASIL     #{DateTime.now.strftime('%Y%m%d')}#{@remessa.as_campo(6,0)}04"
      # str += "DBT10000".as_campo(17) + "".as_campo(52)
      str += "DEBITO AUTOMATICO".as_campo(17) + "".as_campo(52)
      @buffer.puts(str)
    end

    def body
      @registros = 2
      brasil = MeioPagamento.where("nome = 'debito_brasil'").first.id
      Pagamento.includes(:contribuicao => [:unidade,:pessoa,:meio_pagamento,:tipo_contribuicao]).
                where("contribuicoes.meio_pagamento_id = #{brasil} and data_referencia >= ? and data_referencia <= ? and pagamentos.state is null",
                      @data_referencia.beginning_of_month, @data_referencia.end_of_month).each do |pagamento|
        inject(pagamento)
        @buffer.puts(body_line(pagamento))
        @registros += 1
        @valor_total += (pagamento.valor * 100).to_i
      end
    end

    def body_line(obj)
      str  = "E#{obj.id_cliente_empresa.as_campo(13,0)}#{BRANCO.as_campo(12)}#{obj.agencia_debito.to_i.as_campo(4,0)}"
      str += "#{obj.id_cliente_banco.to_i.as_campo(14,0)}#{obj.data_vencimento.strftime('%Y%m%d')}"
      str += "#{obj.valor_debito.as_campo(13,2)}03#{obj.uso_empresa.as_campo(60,0)}#{''.as_campo(20)}#{obj.codigo_movimento}"
    end

    def trailler
      str = "Z#{@registros.as_campo(6,0)}#{@valor_total.as_campo(17,0)}#{''.as_campo(126)}"
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
          self.contribuicao.conta.to_s
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