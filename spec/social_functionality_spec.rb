require 'spec_helper'

describe "Social functionality recognizers" do
  FACEBOOK_LIKE_1 = [<<SOCIAL, :facebook]
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
SOCIAL

  FACEBOOK_LIKE_1_DIV = [<<SOCIAL, :facebook]
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<div class="fb-like" data-href="http://olabini.com" data-send="false" data-width="450" data-show-faces="false" data-font="arial" data-action="recommend"></div>
SOCIAL

  FACEBOOK_LIKE_2_XFBML = [<<SOCIAL, :facebook]
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<fb:like href="http://olabini.com" send="false" width="450" show_faces="false" font="arial" action="recommend"></fb:like>
SOCIAL

  FACEBOOK_LIKE_3_IFRAME = [<<SOCIAL, :facebook]
<iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2Folabini.com&amp;send=false&amp;layout=standard&amp;width=450&amp;show_faces=false&amp;font=arial&amp;colorscheme=light&amp;action=recommend&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:35px;" allowTransparency="true"></iframe>
SOCIAL

  GOOGLE_PLUS = [<<SOCIAL, :google_plus]
<!-- Place this tag where you want the +1 button to render. -->
<div class="g-plusone" data-annotation="inline" data-width="300"></div>

<!-- Place this tag after the last +1 button tag. -->
<script type="text/javascript">
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>
SOCIAL

  GOOGLE_PLUS_2 = [<<SOCIAL, :google_plus]
<script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
<g:plusone></g:plusone>
SOCIAL

  GOOGLE_ADS = [<<SOCIAL, :google_ads]
<script type="text/javascript"><!--
google_ad_client = "ca-pub-5107435762906041";
/* olabini.com/blog */
google_ad_slot = "3306821112";
google_ad_width = 234;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
SOCIAL

  GOOGLE_ANALYTICS = [<<SOCIAL, :google_analytics]
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-17657748-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
SOCIAL

  GOOGLE_WEBFONTS = [<<SOCIAL, :google_webfonts]
<script type="text/javascript">
      WebFontConfig = {
        google: { families: [ 'Tangerine', 'Cantarell' ] }
      };
      (function() {
        var wf = document.createElement('script');
        wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
            '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
        wf.type = 'text/javascript';
        wf.async = 'true';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(wf, s);
      })();
</script>
SOCIAL

  GRAVATAR_1 = [<<SOCIAL, :gravatar]
<img src="http://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50" />
SOCIAL

  GRAVATAR_2 = [<<SOCIAL, :gravatar]
<img src="http://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50.jpg" />
SOCIAL

  GRAVATAR_3 = [<<SOCIAL, :gravatar]
<img src="https://secure.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50.jpg" />
SOCIAL

  TWITTER_1 = [<<SOCIAL, :twitter]
<a href="https://twitter.com/share" class="twitter-share-button" data-via="olabini">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
SOCIAL

  TWITTER_2 = [<<SOCIAL, :twitter]
<a href="https://twitter.com/olabini" class="twitter-follow-button" data-show-count="false">Follow @olabini</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
SOCIAL

  TWITTER_3 = [<<SOCIAL, :twitter]
<a href="https://twitter.com/intent/tweet?button_hashtag=TwitterStories" class="twitter-hashtag-button" data-related="olabini">Tweet #TwitterStories</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
SOCIAL

  TWITTER_4 = [<<SOCIAL, :twitter]
<a href="https://twitter.com/intent/tweet?screen_name=olabini" class="twitter-mention-button" data-related="olabini">Tweet to @olabini</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
SOCIAL

  YOUTUBE_1 = [<<SOCIAL, :youtube]
<iframe width="560" height="315" src="http://www.youtube.com/embed/WbN0nX61rIs" frameborder="0" allowfullscreen></iframe>
SOCIAL

  YOUTUBE_2 = [<<SOCIAL, :youtube]
<iframe width="560" height="315" src="https://www.youtube.com/embed/WbN0nX61rIs" frameborder="0" allowfullscreen></iframe>
SOCIAL

  YOUTUBE_3 = [<<SOCIAL, :youtube]
<iframe width="560" height="315" src="http://www.youtube-nocookie.com/embed/WbN0nX61rIs" frameborder="0" allowfullscreen></iframe>
SOCIAL

  YOUTUBE_4 = [<<SOCIAL, :youtube]
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/WbN0nX61rIs" frameborder="0" allowfullscreen></iframe>
SOCIAL

  YOUTUBE_5 = [<<SOCIAL, :youtube]
<object width="560" height="315"><param name="movie" value="http://www.youtube.com/v/WbN0nX61rIs?version=3&amp;hl=en_US"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/WbN0nX61rIs?version=3&amp;hl=en_US" type="application/x-shockwave-flash" width="560" height="315" allowscriptaccess="always" allowfullscreen="true"></embed></object>
SOCIAL

  ALL = [
    FACEBOOK_LIKE_1,
    FACEBOOK_LIKE_1_DIV,
    FACEBOOK_LIKE_2_XFBML,
    FACEBOOK_LIKE_3_IFRAME,
    GOOGLE_PLUS,
    GOOGLE_PLUS_2,
    GOOGLE_ADS,
    GOOGLE_ANALYTICS,
    GOOGLE_WEBFONTS,
    GRAVATAR_1,
    GRAVATAR_2,
    GRAVATAR_3,
    TWITTER_1,
    TWITTER_2,
    TWITTER_3,
    TWITTER_4,
    YOUTUBE_1,
    YOUTUBE_2,
    YOUTUBE_3,
    YOUTUBE_4,
    YOUTUBE_5
  ]

  ALL.each_with_index do |(cd, expected), ix|
    it "specifically reports social code for #{expected.inspect}, index: #{ix}" do
      @harness = load_harness("http://olabini.com", INLINESCRIPT: cd)
      @harness.reporter.should_receive(:starting).with("http://olabini.com")
      @harness.reporter.should_receive(:external_url).any_number_of_times.with(anything)
      @harness.reporter.should_receive(:social).with(expected)
      @harness.tester.report!
    end
  end
end
