# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wordpressto/version'

Gem::Specification.new do |s|
  s.name            = 'wordpressto'
  s.version         = Wordpressto::VERSION
  s.date            = '2013-01-11'
  
  s.summary         = "A Ruby library to interact with the Wordpress XMLRPC interface"
  s.description     = "A Ruby library to interact with the Wordpress XMLRPC interface"
  
  s.authors         = ['John Leach', 'Piotr Szal']
  s.email           = ['john@johnleach.co.uk', 'Piotr.Szal@akra.de']
  s.homepage        = 'http://github.com/johnl/wordpressto'


  s.has_rdoc        = true

  s.files           = `git ls-files`.split($/)
  s.test_files      = s.files.grep(%r{^(spec)/})

  s.require_paths = ["lib"]

  s.rdoc_options << '--title' << 'Wordpressto' <<
  '--main' << 'README.rdoc' <<
  '--line-numbers'

  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]

  s.add_dependency('mime-types')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', "~> 2.13.0")
  s.add_development_dependency "bundle"
end
