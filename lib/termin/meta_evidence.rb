
class Termin
  class MetaEvidence < Evidence
    attr_reader :link

    def initialize(link)
      @link = link
    end

    def provides
      super + [:meta_refresh, :link]
    end

    def self.from(context, response)
      response.css('meta').select { |x| x["http-equiv"] == "refresh" && x["content"]}.each do |al|
        u = al["content"][/URL=['"]?([^'"]+)['"]?/i, 1]
        yield MetaEvidence.new(context[:uri] + URI.parse(u)) if u
      end
    end
  end
end
