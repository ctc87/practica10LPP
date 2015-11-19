# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pract06/version'

Gem::Specification.new do |spec|
  spec.name          = "pract06"
  spec.version       = Pract06::VERSION
  spec.authors       = ["ctc87"]
  spec.email         = ["carlos.troyano.carmona@gmail.com"]

  spec.summary       = %q{"sum}
  spec.description   = %q{"des"}
  spec.homepage      = "https://bitbucket.org/ctc87/equipotroyano"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 2.11"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov", ">= 0.7.1", "< 1.0.0"

end
