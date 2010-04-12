require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "mollie-ideal"
    gem.summary = %Q{Ruby API for iDEAL with Mollie}
    gem.description = %Q{Ruby API for iDEAL with Mollie}
    gem.email = "peter@pero-ict.nl"
    gem.homepage = "http://github.com/pero-ict/mollie-ideal"
    gem.authors = ["PeRo ICT Solutions"]
    gem.add_dependency 'crack', '>= 0.1.4'
    gem.add_dependency 'httparty', '>= 0.4.5'
    gem.add_dependency 'mash', '>= 0.1.1'
    gem.add_development_dependency 'fakeweb'
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mollie-ideal #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
