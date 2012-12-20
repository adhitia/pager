# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pager/version'

Gem::Specification.new do |gem|
  gem.name          = "pager"
  gem.version       = Pager::VERSION
  gem.authors       = ["Rahmat Budiharso"]
  gem.email         = ["rbudiharso@gmail.com"]
  gem.description   = %q{Forward-only filtered pager}
  gem.summary       = %q{Forward-only filtered pager}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'debugger'
end
