

require 'spec_helper'

describe "Meta" do
  it "doesn't report a local reload" do
    @harness = load_harness("http://olabini.com", METARELOAD: local_reload)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.tester.report!
  end

  it "reports a remote reload" do
    @harness = load_harness("http://olabini.com", METARELOAD: google_reload)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:external_url).with(URI("http://google.com/do_stuff.html"))
    @harness.tester.report!
  end

  it "reports a remote reload with different quote style" do
    @harness = load_harness("http://olabini.com", METARELOAD: google_reload2)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:external_url).with(URI("http://google.com/do_stuff.html"))
    @harness.tester.report!
  end

  it "reports a remote reload with another different quote style" do
    @harness = load_harness("http://olabini.com", METARELOAD: google_reload3)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:external_url).with(URI("http://google.com/do_stuff.html"))
    @harness.tester.report!
  end
end
