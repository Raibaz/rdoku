require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.ruby_opts << "-I."
  t.test_files = FileList['tests/test*.rb']
  t.verbose = true
end