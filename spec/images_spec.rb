
require 'spec_helper'

describe "Termin images" do
  it "reports nothing for an empty harness" do
    @harness = load_harness("http://olabini.com", {})
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.tester.report!
  end

  it "reports an image loaded from google" do
    @harness = load_harness("http://olabini.com", IMG: google_img)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:external_url).with(URI("http://google.com/img/logoWithText-large.png"))
    @harness.tester.report!
  end
end
