# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hellotxt}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin Williams"]
  s.date = %q{2008-12-25}
  s.default_executable = %q{hellotxt}
  s.description = %q{HelloTxt (http://hellotxt.com) is a simple service that makes updating your social networks a snap, and this is it's Ruby library.}
  s.email = ["kevwil@gmail.com"]
  s.executables = ["hellotxt"]
  s.extra_rdoc_files = ["History.txt", "bin/hellotxt"]
  s.files = [".gitignore", "History.txt", "Manifest.txt", "README", "Rakefile", "bin/hellotxt", "lib/hellotxt.rb", "lib/hellotxt/client.rb", "lib/hellotxt/keyloader.rb", "spec/client_spec.rb", "spec/hellotxt_spec.rb", "spec/keyloader_spec.rb", "spec/spec_helper.rb", "spec/spec_responses.rb", "tasks/ann.rake", "tasks/bones.rake", "tasks/gem.rake", "tasks/git.rake", "tasks/manifest.rake", "tasks/notes.rake", "tasks/post_load.rake", "tasks/rdoc.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://kevwil.github.com/hellotxt}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{hellotxt}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{HelloTxt (http://hellotxt}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 2.1.1"])
    else
      s.add_dependency(%q<bones>, [">= 2.1.1"])
    end
  else
    s.add_dependency(%q<bones>, [">= 2.1.1"])
  end
end
