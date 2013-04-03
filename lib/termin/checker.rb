
module Termin
  module Checker
    class ExternalLink
      def subdomain?(left, right)
        l = left.split(/\./).reverse
        r = right.split(/\./).reverse
        l == r.take(l.length)
      end

      def needs
        [:link]
      end

      def check context, evidence
        if !subdomain?(context.host.to_s, evidence.link.host.to_s)
          puts "  FOUND EXTERNAL URL: #{evidence.link}"
        end
      end
    end

    class CssUrl
      def needs
        [:css, :content]
      end

      def check context, evidence
        evidence.content.each_rule_set do |rs|
          rs.each_declaration do |nm, val, imp|
            if val =~ /url\s+\((.*?)\)/
              puts "  FOUND EXTERNAL URL: #{$1}"
            end
          end
        end
      end
    end

    def self.all
      [ExternalLink.new, CssUrl.new]
    end
  end
end
