
require 'spec_helper'

describe "Inline script" do
  it "gives a head scripts to checkers that require it" do
    @harness = load_harness("http://olabini.com", HEADSCRIPT: "<script>foo bar</script>", INLINESCRIPT: nil)
    inline_script_checker = Object.new
    @harness.tester.checkers << inline_script_checker
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    inline_script_checker.should_receive(:needs).any_number_of_times.and_return([:javascript, :content])
    inline_script_checker.should_receive(:check).with(anything(), Termin::JavascriptEvidence.new("foo bar"))
    @harness.tester.report!
  end

  it "gives an inline scripts to checkers that require it" do
    @harness = load_harness("http://olabini.com", INLINESCRIPT: "<script>I'm inline</script>", )
    inline_script_checker = Object.new
    @harness.tester.checkers << inline_script_checker
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    inline_script_checker.should_receive(:needs).any_number_of_times.and_return([:javascript, :content])
    inline_script_checker.should_receive(:check).with(anything(), Termin::JavascriptEvidence.new("I'm inline"))
    @harness.tester.report!
  end

  it "gives all scripts to checkers that require it" do
    @harness = load_harness("http://olabini.com", HEADSCRIPT: "<script>foo bar</script>", INLINESCRIPT: "<script>I'm inline</script>", )
    inline_script_checker = Object.new
    @harness.tester.checkers << inline_script_checker
    @harness.reporter.should_receive(:starting).with("http://olabini.com")
    inline_script_checker.should_receive(:needs).any_number_of_times.and_return([:javascript, :content])
    inline_script_checker.should_receive(:check).with(anything(), Termin::JavascriptEvidence.new("foo bar"))
    inline_script_checker.should_receive(:check).with(anything(), Termin::JavascriptEvidence.new("I'm inline"))
    @harness.tester.report!
  end
end
