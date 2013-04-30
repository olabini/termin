require 'spec_helper'

describe "Termin CSS" do
  it "reports a url element loaded in CSS with a space before the url element" do
    @harness = load_harness("http://olabini.com", SCRIPTLINK: local_script_link, CSSURL: "url ('https://google.com/img/logoWithText-large.png')")
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:external_url).with(URI("https://google.com/img/logoWithText-large.png"))
    @harness.tester.report!
  end

  it "reports a url element loaded in CSS" do
    @harness = load_harness("http://olabini.com", SCRIPTLINK: local_script_link, CSSURL: "url('https://google.com/img/logoWithText-large.png')")
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:external_url).with(URI("https://google.com/img/logoWithText-large.png"))
    @harness.tester.report!
  end
end
