require 'spec_helper'

RSpec.describe 'Caching', type: :cell do
  let(:subject) { self.class }

  it 'module is included' do
    expect(subject.included_modules).to include(RSpec::Cells::Caching)
  end

  it { expect(subject).to respond_to(:enable_cell_caching!) }
  it { expect(subject).to respond_to(:disable_cell_caching!) }

end
