begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

ensure_in_path 'lib'
require 'hellotxt'

task :default => 'spec:run'
task 'gem:release' => 'spec:run'

Bones {
  name 'hellotxt'
  authors ['Kevin Williams']
  email ['kevwil@gmail.com']
  url 'http://kevwil.github.com/hellotxt'
  version ENV['VERSION'] || HelloTxt::VERSION::STRING
  readme_file 'README'
  ignore_file '.gitignore'
  gem.need_tar false
  depend_on 'bones', :development => true
  depend_on 'rspec', :development => true
  depend_on 'mocha', :development => true
  ruby_opts << '-Ilib' << '-rubygems'
  spec.opts << '--color'# << '--format html:./spec_out.html'
  rcov.opts << ['--exclude', 'rcov']
  rcov.opts << ['--exclude', 'mocha']
  # enable_sudo
}

# EOF
