
class Termin
  class ObjectEvidence < Evidence
    attr_reader :params
    attr_reader :embed

    def initialize(params, embed)
      @params = params
      @embed = embed
    end

    def provides
      super + [:object]
    end

    def self.from(context, response)
      response.css('object').each do |al|
        ps = Hash[al.css('param').map do |el|
          [el["name"], el["value"]]
        end]
        es = al.css('embed').map { |xx| context[:uri] + URI.parse(xx["src"]) }
        yield ObjectEvidence.new ps, es
      end
    end
  end
end
