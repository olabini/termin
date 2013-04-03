
module Termin
  class JavascriptEvidence < Evidence
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def provides
      super + [:javascript, :content]
    end

    class Linked < JavascriptEvidence
      attr_reader :link

      def initialize(link)
        @link = link
        super HTTParty.get(link.to_s).body
      end

      def provides
        super + [:link]
      end
    end

    self.extend EvidenceUtils

    def self.from(context, response)
      response.css('script').select { |x| x["type"] == "text/javascript" && x["src"] }.map { |x| context[:uri] + URI.parse(with_prefix(context[:uri].scheme, x["src"])) }.each do |al|
        yield Linked.new(al)
      end
    end
  end
end
