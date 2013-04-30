require 'httparty'

class Termin
  class HTTPLoader
    def get url
      HTTParty.get url
    end
  end
end
