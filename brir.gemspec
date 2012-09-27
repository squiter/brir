# -*- encoding: utf-8 -*-
require File.expand_path('../lib/brir/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brunno dos Santos"]
  gem.email         = ["brunno@brunno.me"]
  gem.description   = %q{Brir provide a interface to calculate Brazilian Icome Taxes (IRPF and IRPJ)}
  gem.summary       = %q{Calculate Brazilian Icome Taxes}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "brir"
  gem.require_paths = ["lib"]
  gem.version       = Brir::VERSION
end
