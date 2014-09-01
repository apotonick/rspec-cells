require_relative '../../spec_helper'

# Generators are not automatically loaded by Rails
require 'generators/rspec/cell/cell_generator'

RSpec.describe Rspec::Generators::CellGenerator, :type => :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  destination File.expand_path('../../../../tmp', __FILE__)

  before { prepare_destination }

  describe 'the generated files' do
    before { run_generator %w(stem bone blood) }

    subject { file('spec/cells/stem_cell_spec.rb') }
    it { is_expected.to exist }

    context 'creates widget spec' do
      it { is_expected.to contain(/require 'rails_helper'/) }
      it { is_expected.to contain(/describe StemCell, type: :cell do/) }
      it { is_expected.to contain(/context \'cell rendering\' do/) }
      it { is_expected.to contain(/end/) }
    end

    context 'creates bone state' do
      it { is_expected.to contain('context \'rendering bone\' do') }
      it { is_expected.to contain('render_state(:bone)') }
      it { is_expected.to contain('is_expected.to have_selector(\'h1\', text: \'StemCell#bone\')') }
      it { is_expected.to contain('is_expected.to have_selector(\'p\', text: \'Find me in app/cells/stem/bone.html\')') }
      it { is_expected.to contain('end') }
    end

    context 'creates blood state' do
      it { is_expected.to contain('context \'rendering blood\' do') }
      it { is_expected.to contain('render_state(:blood)') }
      it { is_expected.to contain('is_expected.to have_selector(\'h1\', text: \'StemCell#blood\')') }
      it { is_expected.to contain('is_expected.to have_selector(\'p\', text: \'Find me in app/cells/stem/blood.html\')') }
      it { is_expected.to contain('end') }
    end
  end

  context 'namespace' do
    before { run_generator %w(fake/boob xxxl) }

    subject { file('spec/cells/fake/boob_cell_spec.rb') }
    it { is_expected.to exist }

    context 'creates widget spec' do
      it { is_expected.to contain(/require 'rails_helper'/) }
      it { is_expected.to contain(/describe Fake::BoobCell, type: :cell do/) }
      it { is_expected.to contain(/context \'cell rendering\' do/) }
      it { is_expected.to contain(/end/) }
    end

    context 'creates xxxl state' do
      it { is_expected.to contain('context \'rendering xxxl\' do') }
      it { is_expected.to contain('render_state(:xxxl)') }
      it { is_expected.to contain('is_expected.to have_selector(\'h1\', text: \'Fake::BoobCell#xxxl\')') }
      it { is_expected.to contain('is_expected.to have_selector(\'p\', text: \'Find me in app/cells/fake/boob/xxxl.html\')') }
      it { is_expected.to contain('end') }
    end

  end

end