require 'nokogiri'
require 'uri'

require 'termin/evidence'
require 'termin/checker'
require 'termin/reporter'
require 'termin/loader'

class Termin
  class << self
    def default_reporter
      Termin::ConsoleReporter.new
    end

    def default_loader
      Termin::HTTPLoader.new
    end

    def default_checkers
      Checker.all
    end

    def default_evidence
      [CookiesEvidence, ImagesEvidence, CssEvidence, JavascriptEvidence, IFrameEvidence, MetaEvidence, ObjectEvidence]
    end

    def report_on url
      Termin.new(url).report!
    end
  end

  attr_accessor :url, :reporter, :loader, :checkers, :evidence

  def initialize(url, reporter = Termin.default_reporter, loader = Termin.default_loader, checkers = Termin.default_checkers, evidence = Termin.default_evidence)
    @url = url
    @reporter = reporter
    @loader = loader
    @checkers = checkers
    @evidence = evidence
  end

  def apply_checkers context, evidence
    @checkers.each do |c|
      if (c.needs - evidence.provides).empty?
        c.check context, evidence
      end
    end
  end

  def report!
    @reporter.starting @url
    re = @loader.get @url
    response = Nokogiri::HTML(re.body)
    uri = URI.parse @url
    context = {uri: uri, full_response: re, termin: self}
    @evidence.each do |evc|
      evc.from(context, response) do |e|
        apply_checkers context, e
      end
    end
  end
end
