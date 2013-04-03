
module Termin
  module EvidenceUtils
    def with_prefix(prefix, ur)
      if ur =~ %r[^//]
        "#{prefix}:#{ur}"
      else
        ur
      end
    end
  end
  class Evidence
    def provides
      []
    end
  end
end

require 'termin/javascript_evidence'
require 'termin/css_evidence'
require 'termin/cookies_evidence'
require 'termin/images_evidence'
