# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

begin
  require 'bones'
  Bones.setup
rescue LoadError
  load 'tasks/setup.rb'
end

ensure_in_path 'lib'
require 'hellotxt'

task :default => 'spec:run'

PROJ.name = 'hellotxt'
PROJ.authors = ['Kevin Williams']
PROJ.email = ['kevwil@gmail.com']
PROJ.url = 'http://kevwil.github.com/hellotxt'
PROJ.version = ENV['VERSION'] || HelloTxt::VERSION
PROJ.rubyforge.name = 'hellotxt'
PROJ.readme_file = 'README'

PROJ.gem.need_tar = false

PROJ.spec.opts << '--color'
PROJ.rcov.opts << ['--exclude', 'rcov']
PROJ.rcov.opts << ['--exclude', 'mocha']

namespace :gem do
  desc 'create a gemspec file to support github gems'
  task :gemspec => 'gem:prereqs' do
    File.open("#{PROJ.name}.gemspec", 'w+') do |f|
      f.write PROJ.gem._spec.to_ruby
    end
  end
end

# EOF
