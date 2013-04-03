
module Termin
  class CookiesEvidence < Evidence
    def initialize(cc)
      @cookie = cc
    end

    def provides
      [:cookie]
    end

    def self.from(context, response)
      Array(context[:full_response].headers["set-cookie"]).each do |cc|
        yield CookiesEvidence.new(cc)
      end
    end
  end
end
