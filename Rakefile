$: << "lib"

require 'rake/clean'
require 'rspec/core/rake_task'
require 'termin'

desc "Run specs"
RSpec::Core::RakeTask.new

task :run do
  Termin.report_on "http://thoughtworks.com"
  Termin.report_on "http://olabini.com/blog"
  Termin.report_on "http://hopenumbernine.net"
  Termin.report_on "http://occupyoakland.org"
  Termin.report_on "http://internetdefenseleague.org"
  Termin.report_on "http://adbusters.org"
  Termin.report_on "http://anonnews.org"
  Termin.report_on "http://news.infoshop.org"
end
