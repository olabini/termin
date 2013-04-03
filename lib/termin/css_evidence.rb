require 'httparty'
require 'css_parser'

module Termin
  class CssEvidence < Evidence
    def initialize(content)
      @content = content
      @parsed = CssParser::Parser.new
      @parsed.load_string! @content
    end

    def content
      @parsed
    end

    def provides
      super + [:css, :content]
    end

    class Linked < CssEvidence
      attr_reader :link

      def initialize(link)
        @link = link
        super HTTParty.get(link.to_s).body
      end

      def provides
        super + [:link]
      end
    end

    def self.from(context, response)
      response.css('link').select { |x| x["type"] == "text/css" }.map { |x| context[:uri] + URI.parse(x["href"]) }.each do |al|
        yield Linked.new(al)
      end

      response.css('style').select { |x| x["type"] == "text/css" }.each do |st|
        yield CssEvidence.new(st.content)
      end
    end
  end
end
