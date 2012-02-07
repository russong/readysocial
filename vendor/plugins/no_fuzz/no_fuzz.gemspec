# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{no_fuzz}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bj\303\270rn Arild M\303\246land, Michel Benevento"]
  s.date = %q{2011-03-14}
  s.description = %q{No Fuzz}
  s.email = %q{michelbenevento@yahoo.com}
  s.extra_rdoc_files = ["README.markdown", "tasks/no_fuzz_tasks.rake", "lib/no_fuzz.rb", "CHANGELOG"]
  s.files = ["Rakefile", "README.markdown", "no_fuzz.gemspec", "tasks/no_fuzz_tasks.rake", "lib/no_fuzz.rb", "lib/generators/no_fuzz/USAGE", "lib/generators/no_fuzz/templates/migration.rb", "lib/generators/no_fuzz/templates/model.rb", "lib/generators/no_fuzz/no_fuzz_generator.rb", "MIT-LICENSE", "test/no_fuzz_test.rb", "test/database.yml", "test/schema.rb", "test/test_helper.rb", "CHANGELOG"]
  s.has_rdoc = 
  s.homepage = %q{http://github.com/beno/no_fuzz}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "No_fuzz", "--main", "README.markdown"]
  s.require_path = "lib"
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{No Fuzz}
  s.test_files = ["test/no_fuzz_test.rb", "test/test_helper.rb"]
  s.add_dependency('echoe')

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
