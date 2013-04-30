class FixedResponse
  attr_reader :body

  def initialize(str, cookies = [])
    @body = str
    @cookies = cookies
  end

  def headers
    if @cookies && !@cookies.empty?
      {"set-cookie" => @cookies}
    else
      {}
    end
  end
end

class FixedLoader
  def initialize(html_str, css_str, cookies)
    @html_content = FixedResponse.new html_str, cookies
    @css_content = FixedResponse.new css_str
  end

  def get url
    if url =~ /\.css$/
      @css_content
    else
      @html_content
    end
  end
end

Harness = Struct.new(:tester, :loader, :reporter)

def google_img
  "<img src='http://google.com/img/logoWithText-large.png' title='Ola Bini: Programming Language Synchronicity'>"
end

def local_script_link
  "<link rel=\"stylesheet\" type=\"text/css\" href=\"local.css\">"
end

def local_external_script
  "<script src=\"/javascripts/onready.js\" type=\"text/javascript\"></script>"
end

def google_external_script
  "<script src=\"http://google.com/scripts/foo.js\" type=\"text/javascript\"></script>"
end

def local_iframe
  "<iframe src=\"foo.html\"></iframe>"
end

def google_iframe
  "<iframe src=\"http://google.com/stuff.html\"></iframe>"
end

def load_harness(url, inserts)
  cookies = inserts[:COOKIES] || []
  html_str = File.read(File.join(File.dirname(__FILE__), "harness.html")).gsub(/<<<CONTENT:(.*?)>>>/) do
    inserts[$1.to_sym] || ""
  end
  css_str = File.read(File.join(File.dirname(__FILE__), "harness.css")).gsub(/<<<CONTENT:(.*?)>>>/) do
    inserts[$1.to_sym] || ""
  end
  loader = FixedLoader.new(html_str, css_str, cookies)
  reporter = Object.new
  t = Termin.new(url, reporter, loader)
  Harness.new(t, loader, reporter)
end
