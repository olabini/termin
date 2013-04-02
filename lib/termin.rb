require 'httparty'
require 'nokogiri'
require 'uri'
require 'css_parser'

module Termin
  def self.report_on url
    puts "REPORTING ON: -------- #{url} --------"
    re = HTTParty.get(url)
    response = Nokogiri::HTML(re.body)
    uri = URI.parse url
    extract_all_css(uri, response)
    extract_all_javascript(uri, response)
  end

  def self.report_external(uri)
    puts "  FOUND EXTERNAL URL: #{uri}"
  end

  def self.subdomain?(left, right)
    l = left.split(/\./).reverse
    r = right.split(/\./).reverse
    l == r.take(l.length)
  end

  def self.with_prefix(prefix, ur)
    if ur =~ %r[^//]
      "#{prefix}:#{ur}"
    else
      ur
    end
  end

  def self.extract_all_javascript(baseurl, resp)
    resp.css('script').select { |x| x["type"] == "text/javascript" && x["src"] }.map { |x| baseurl + URI.parse(with_prefix(baseurl.scheme, x["src"])) }.each do |al|
      if !subdomain?(baseurl.host, al.host)
        report_external al
      end
    end
  end

  def self.extract_all_css(baseurl, resp)
    all_css_content = []
    all_links = resp.css('link').select { |x| x["type"] == "text/css" }.map { |x| baseurl + URI.parse(x["href"]) }
    all_links.each do |al|
      pp = CssParser::Parser.new
      pp.load_string! HTTParty.get(al.to_s).body
      all_css_content << pp
      if !subdomain?(baseurl.host, al.host)
        report_external al
      end
    end

    resp.css('style').select { |x| x["type"] == "text/css" }.each do |st|
      pp = CssParser::Parser.new
      pp.load_string! st.content
      all_css_content << pp
    end

    all_css_content.each do |cs|
      cs.each_rule_set do |rs|
        rs.each_declaration do |nm, val, imp|
          if val =~ /url\s+\((.*?)\)/
            report_external $1
          end
        end
      end
    end
  end
end
