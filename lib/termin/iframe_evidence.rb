
class Termin
  class IFrameEvidence < Evidence
    attr_reader :link

    def initialize(link)
      @link = link
    end

    def provides
      super + [:iframe, :link]
    end

    def self.from(context, response)
      response.css('iframe').select { |x| x["src"] }.map { |x| context[:uri] + URI.parse(x["src"]) }.each do |al|
        yield IFrameEvidence.new(al)
      end
    end
  end
end
