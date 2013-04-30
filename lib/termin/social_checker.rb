
class Termin
  module Checker
    module Social
      class JavascriptRecognizer < Struct.new(:re, :result)
        include Checker
        def needs; [:javascript, :content]; end
        def check context, evidence
          if self.re =~ evidence.content
            context[:termin].reporter.social self.result
          end
        end
      end

      class LinkRecognizer < Struct.new(:re, :result)
        include Checker
        def needs; [:link]; end
        def check context, evidence
          if self.re =~ evidence.link.to_s
            context[:termin].reporter.social self.result
          end
        end
      end

      class IFrameRecognizer < LinkRecognizer
        def needs; [:iframe, :link]; end
      end

      class YoutubeObjectRecognizer < Struct.new(:re, :result)
        include Checker
        def needs; [:object]; end
        def check context, evidence
          if evidence.embed.any? { |x| %r[https?://www\.youtube\.com/v/] =~ x.to_s }
            context[:termin].reporter.social :youtube
          end
        end
      end

      Facebook = JavascriptRecognizer.new   %r[//connect.facebook.net/en_US/all.js#xfbml=1], :facebook
      Facebook2 = IFrameRecognizer.new      %r[//www\.facebook\.com/plugins/like\.php], :facebook
      GoogleAds = LinkRecognizer.new        %r[http://pagead2\.googlesyndication\.com/pagead/show_ads\.js], :google_ads
      GoogleAnalytics  = JavascriptRecognizer.new %r[google-analytics\.com/ga\.js], :google_analytics
      GoogleAnalytics2 = LinkRecognizer.new %r[google-analytics\.com/ga\.js], :google_analytics
      GoogleWebfonts  = JavascriptRecognizer.new %r[//ajax\.googleapis\.com/ajax/libs/webfont/[^/]*/webfont\.js], :google_webfonts
      GoogleWebfonts2 = LinkRecognizer.new %r[//ajax\.googleapis\.com/ajax/libs/webfont/[^/]*/webfont\.js], :google_webfonts
      GooglePlus = JavascriptRecognizer.new %r[//apis\.google\.com/js/plusone\.js], :google_plus
      Gravatar = LinkRecognizer.new         %r[https?://(www|secure)\.gravatar\.com/avatar/], :gravatar
      Twitter  = JavascriptRecognizer.new   %r[//platform\.twitter\.com/widgets\.js], :twitter
      Twitter2 = LinkRecognizer.new         %r[//platform\.twitter\.com/widgets\.js], :twitter
      Youtube  = IFrameRecognizer.new       %r[//www\.youtube(-nocookie)?\.com/embed/], :youtube
      ShareThis  = LinkRecognizer.new       %r[//w\.sharethis\.com/button/buttons\.js], :share_this

      def self.all
        [Facebook, Facebook2, GoogleAds, GoogleAnalytics, GoogleAnalytics2, GoogleWebfonts, GoogleWebfonts2, GooglePlus, Gravatar, Twitter, Twitter2, Youtube, YoutubeObjectRecognizer.new, ShareThis]
      end
    end
  end
end
