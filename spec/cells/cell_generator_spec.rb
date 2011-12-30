require "generators/rspec/cell_generator"

describe Rspec::Generators::CellGenerator do
  include RSpec::Rails::RailsExampleGroup

  attr_accessor :test_case, :test

  before(:all) do
    test_case = Class.new(Rails::Generators::TestCase)
    test_case.destination_root = File.expand_path("../../tmp", __FILE__)
    test_case.generator_class = Rspec::Generators::CellGenerator
    self.test = test_case.new :wow
    test.run_generator %w(Twitter display form)
  end

  def t(line_code)
    Regexp.new(Regexp.escape(line_code))
  end

  it "creates widget spec" do
    test.assert_file "spec/cells/twitter_cell_spec.rb", t("require 'spec_helper'")
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('describe TwitterCell do')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('context "cell rendering" do')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('end')
  end
  
  it 'creates display state' do
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('context "rendering display" do')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('subject { render_cell(:twitter, :display) }')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('it { should have_selector("h1", :content => "Twitter#display") }')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('it { should have_selector("p", :content => "Find me in app/cells/twitter/display.html") }')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('end')
  end
  
  it 'creates form state' do
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('context "rendering form" do')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('subject { render_cell(:twitter, :form) }')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('it { should have_selector("h1", :content => "Twitter#form") }')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('it { should have_selector("p", :content => "Find me in app/cells/twitter/form.html") }')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('end')
  end

  it 'creates respond_to states specs' do
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('context "cell instance" do ')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('subject { cell(:twitter) } ')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('it { should respond_to(:display) }')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('it { should respond_to(:form) }')
    test.assert_file "spec/cells/twitter_cell_spec.rb", t('end')
  end
end
