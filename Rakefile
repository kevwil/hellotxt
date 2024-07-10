begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

ensure_in_path 'lib'
require 'hellotxt'

task :default => 'spec:run'
task 'gem:release' => 'spec:run'

Bones do
  name 'hellotxt'
  authors ['Kevin Williams']
  email ['kevwil@gmail.com']
  url 'https://kevwil.github.io/hellotxt'
  version ENV['VERSION'] || HelloTxt::VERSION::STRING
  readme_file 'README'
  ignore_file '.gitignore'
  gem.need_tar false
  depend_on 'simplecov', :development => true
  depend_on 'rspec', :development => true
  depend_on 'mocha', :development => true
  depend_on 'bones-git', :development => true
  depend_on 'bones-rspec', :development => true
  # ruby_opts << '-Ilib' << '-rubygems'
  ruby_opts << '-Ilib'
  test.opts << '--color'# << '--format html:./spec_out.html'
  # rcov.opts << ['--exclude', 'rcov']
  # rcov.opts << ['--exclude', 'mocha']
  use_gmail
  enable_sudo
end

# EOF
