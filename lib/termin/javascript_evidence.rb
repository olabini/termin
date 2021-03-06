
class Termin
  class JavascriptEvidence < Evidence
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def provides
      super + [:javascript, :content]
    end

    def ==(o)
      self.content == o.content
    end

    class Linked < JavascriptEvidence
      attr_reader :link

      def initialize(context, link)
        @link = link
        super context[:termin].loader.get(link.to_s).body
      end

      def provides
        super + [:link]
      end
    end

    self.extend EvidenceUtils

    def self.from(context, response)
      response.css('script').select { |x| x["type"] == "text/javascript" && x["src"] }.map { |x| context[:uri] + URI.parse(with_prefix(context[:uri].scheme, x["src"])) }.each do |al|
        yield Linked.new(context, al)
      end
      response.css('script').select { |x| !x["src"]}.each do |al|
        yield JavascriptEvidence.new(al.content)
      end
    end
  end
end
