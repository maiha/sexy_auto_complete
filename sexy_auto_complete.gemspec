# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sexy_auto_complete}
  s.version = "0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["maiha"]
  s.date = %q{2009-02-24}
  s.description = %q{Rails plugin for better auto_complete, especially it gets along with ActiveScaffold nested forms}
  s.email = %q{maiha@wota.jp}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["LICENSE", "README", "Rakefile", "lib/sexy_auto_complete", "lib/sexy_auto_complete/helper.rb", "lib/sexy_auto_complete/controller.rb", "lib/sexy_auto_complete.rb", "tasks/auto_complete_tasks.rake", "test/auto_complete_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/maiha/sexy_auto_complete}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Rails plugin for better auto_complete, especially it gets along with ActiveScaffold nested forms}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
