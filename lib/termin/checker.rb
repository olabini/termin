
class Termin
  module Checker
    def subdomain?(left, right)
      l = left.split(/\./).reverse
      r = right.split(/\./).reverse
      l == r.take(l.length)
    end

    class ExternalLink
      include Checker
      def needs
        [:link]
      end

      def check context, evidence
        if !subdomain?(context[:uri].host.to_s, evidence.link.host.to_s)
          context[:termin].reporter.external_url evidence.link
        end
      end
    end

    class CssUrl
      include Checker
      def needs
        [:css, :content]
      end

      def check context, evidence
        evidence.content.each_rule_set do |rs|
          rs.each_declaration do |nm, val, imp|
            if val =~ /url\s*\((.*?)\)/
              d = $1
              if d =~ /^'.*?'$/ || d =~ /^".*?"$/
                d = d[1..-2]
              end
              u = context[:uri] + URI(d)
              if !subdomain?(context[:uri].host.to_s, u.host.to_s)
                context[:termin].reporter.external_url u
              end
            end
          end
        end
      end
    end

    class Cookies
      include Checker
      def needs; [:cookie]; end
      def check context, evidence
        context[:termin].reporter.cookie evidence.cookie
      end
    end

    def self.all
      [ExternalLink.new, CssUrl.new, Cookies.new]
    end
  end
end
