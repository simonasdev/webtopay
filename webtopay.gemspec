# stub: webtopay 2.0 ruby libhttparty

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

  httparty, version = 'httparty', [">= 0.11.0"]
  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(httparty, version)
    else
      s.add_dependency(httparty, version)
    end
  else
    s.add_dependency(httparty, version)
  end
end