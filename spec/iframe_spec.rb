require 'spec_helper'

describe "IFrame" do
  it "doesn't report a local html" do
    @harness = load_harness("http://olabini.com", IFRAME: local_iframe)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.tester.report!
  end

  it "reports a remote html" do
    @harness = load_harness("http://olabini.com", IFRAME: google_iframe)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:external_url).with(URI("http://google.com/stuff.html"))
    @harness.tester.report!
  end
end
