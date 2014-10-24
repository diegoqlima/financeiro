$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "financeiro/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "financeiro"
  s.version     = Financeiro::VERSION
  s.authors     = ["Raro Labs"]
  s.email       = ["contato@rarolabs.com.br"]
  s.homepage    = "http://www.rarolabs.com.br"
  s.summary     = "Integração dos meios de pagamento."
  s.description = "Integração dos meios de pagamento."
  
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "transitions"
  s.add_dependency "pagseguro-oficial"
  s.add_dependency "carrierwave"

  s.add_development_dependency "sqlite3"
end
