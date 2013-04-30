
require 'spec_helper'

describe "External scripts" do
  it "doesn't report a local script" do
    @harness = load_harness("http://olabini.com", SCRIPTLINK: local_external_script)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.tester.report!
  end

  it "reports a remote external script" do
    @harness = load_harness("http://olabini.com", SCRIPTLINK: google_external_script)
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:external_url).with(URI("http://google.com/scripts/foo.js"))
    @harness.tester.report!
  end
end
