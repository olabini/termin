require 'spec_helper'

describe "Cookies" do
  it "doesn't report any cookies when no given" do
    @harness = load_harness("http://olabini.com", {})
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.tester.report!
  end

  it "report all cookies" do
    @harness = load_harness("http://olabini.com", COOKIES: ["one", "two"])
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    @harness.reporter.should_receive(:cookie).with("one")
    @harness.reporter.should_receive(:cookie).with("two")
    @harness.tester.report!
  end
end
