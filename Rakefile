$: << "lib"

require 'rake/clean'
require 'rspec/core/rake_task'
require 'termin'

desc "Run specs"
RSpec::Core::RakeTask.new

task :run do
  Termin.report_on "http://thoughtworks.com"
  # ???

  Termin.report_on "http://olabini.com/blog"
  # # # ???

  Termin.report_on "http://hopenumbernine.net"
  # Google, Twitter

  Termin.report_on "http://occupyoakland.org"
  # # # Google, Twitter, Facebook, ShareThis

  Termin.report_on "http://internetdefenseleague.org"
  # # # Google, Twitter, Facebook, Heroku

  Termin.report_on "http://adbusters.org"
  # # # Google, Twitter, Youtube, PayPal

  Termin.report_on "http://anonnews.org"
  # # # Google, Creative Commons, Flattr, CryptoCC

  Termin.report_on "http://news.infoshop.org"
  # # # Google, PayPal, WePay, Constant Contact, Counterpunch
end
