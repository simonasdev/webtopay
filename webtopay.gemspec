# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "webtopay/version"

Gem::Specification.new do |s|
  s.name        = "webtopay"
  s.version     = WebToPay::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Laurynas Butkus", "Kristijonas Urbaitis"]
  s.email       = ["laurynas.butkus@gmail.com", "kristijonas.urbaitis@gmail.com"]
  s.homepage    = "https://github.com/kurbaitis/webtopay"
  s.summary     = %q{Provides integration with http://www.webtopay.com (mokejimai.lt) payment system}
  s.description = %q{WebToPay (mokejimai.lt) API ruby implementation}

  #s.rubyforge_project = "webtopay"

  s.files         = `ls`.split("\n")
  s.require_paths = ["lib", "httparty"]

  s.add_dependency "httparty", '>= 0.11.0'
  s.add_runtime_dependency "httparty", '>= 0.11.0'
  s.add_development_dependency "httparty", '>= 0.11.0'
end

