require 'rake/testtask'

Rake::TestTask.new do |t|
  test_files = FileList['test/**/*/**/*_test.rb']
  puts test_files.inspect
  t.test_files = FileList['test/**/*/**/*_test.rb']
  t.verbose = true
end
