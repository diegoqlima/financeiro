class String
  def as_campo(size = self.size())
    if self.size > size
      self.slice(0..size-1)
    else
      brancos = " " * (size - self.size())
      self + brancos
    end
  end
  
  def caracter_especial
    descricao = self
    descricao = descricao.gsub("Á", "á");
    descricao = descricao.gsub("É", "é");
    descricao = descricao.gsub("Í", "í");
    descricao = descricao.gsub("Ó", "ó");
    descricao = descricao.gsub("Ú", "ú");
    descricao = descricao.gsub("Â", "â");
    descricao = descricao.gsub("Ê", "ê");
    descricao = descricao.gsub("Ô", "ô");
    descricao = descricao.gsub("Î", "î");
    descricao = descricao.gsub("Û", "û");
    descricao = descricao.gsub("Ã", "ã");
    descricao = descricao.gsub("Ẽ", "ẽ");
    descricao = descricao.gsub("Ĩ", "ĩ");
    descricao = descricao.gsub("Õ", "õ");
    descricao = descricao.gsub("Ũ", "ũ");
    descricao = descricao.gsub("Ç", "ç");
    descricao = descricao.gsub("À", "à");
    descricao
  end
end

class Numeric
  def as_campo(i,d)
    x = (d!=0) ?  "1" + ("0" * d) : 1
    n = (self.abs * x.to_i).to_i.to_s
    brancos = "0" * ((i + d) - n.size) 
    brancos + n
  end
  
  def sinal
    (self < 0) ? 'C' : 'D'
  end
      
end