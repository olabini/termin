
class Termin
  class ImagesEvidence < Evidence
    attr_reader :link

    def initialize(link)
      @link = link
    end

    def provides
      super + [:image, :link]
    end

    def self.from(context, response)
      response.css('img').select { |x| x["src"] }.map { |x| context[:uri] + URI.parse(x["src"]) }.each do |al|
        yield ImagesEvidence.new(al)
      end
    end
  end
end
