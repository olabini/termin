require 'httparty'
require 'nokogiri'
require 'uri'

require 'termin/evidence'
require 'termin/checker'

module Termin
  def self.apply_checkers context, checkers, evidence
    checkers.each do |c|
      if (c.needs - evidence.provides).empty?
        c.check context, evidence
      end
    end
  end

  def self.report_on url
    puts "REPORTING ON: -------- #{url} --------"
    re = HTTParty.get(url)
    response = Nokogiri::HTML(re.body)
    uri = URI.parse url
    checkers = Checker.all
    [CookiesEvidence, ImagesEvidence, CssEvidence, JavascriptEvidence].each do |evc|
      evc.from({uri: uri, full_response: re}, response) do |e|
        apply_checkers uri, checkers, e
      end
    end
  end
end
