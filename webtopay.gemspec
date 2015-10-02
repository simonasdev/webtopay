# -*- encoding: utf-8 -*-
# stub: webtopay 2.0 ruby lib httparty

Gem::Specification.new do |s|
  s.name = "webtopay"
  s.version = "2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib", "httparty"]
  s.authors = ["Laurynas Butkus", "Kristijonas Urbaitis"]
  s.date = "2015-09-02"
  s.description = "WebToPay (mokejimai.lt) API ruby implementation"
  s.email = ["laurynas.butkus@gmail.com", "kristijonas.urbaitis@gmail.com"]
  s.files = ["Gemfile", "README.md", "Rakefile", "init.rb", "lib", "spec", "webtopay.gemspec"]
  s.homepage = "https://github.com/kurbaitis/webtopay"
  s.rubygems_version = "2.2.2"
  s.summary = "Provides integration with http://www.webtopay.com (mokejimai.lt) payment system"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.11.0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.11.0"])
      s.add_development_dependency(%q<httparty>, [">= 0.11.0"])
    else
      s.add_dependency(%q<httparty>, [">= 0.11.0"])
      s.add_dependency(%q<httparty>, [">= 0.11.0"])
      s.add_dependency(%q<httparty>, [">= 0.11.0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.11.0"])
    s.add_dependency(%q<httparty>, [">= 0.11.0"])
    s.add_dependency(%q<httparty>, [">= 0.11.0"])
  end
end
