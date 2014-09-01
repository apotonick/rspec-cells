require 'spec_helper'

class GeneticCell < Cell::Base
  prepend_view_path "#{Rails.root}/spec/cells"

  def analyze(disease)
    "<h1>Analyzing #{disease}.</h1>"
  end

  def cure
    @lol = 'LOL!'
    render
  end
end

RSpec.describe 'GeneticCell', type: :cell do
  context 'cell rendering' do
    context 'rendering analyze' do
      subject { render_cell('genetic', :analyze, 'Ebola') }

      it { is_expected.to have_selector('h1', text: 'Analyzing Ebola.') }
    end

    context 'rendering analyze' do
      subject { render_cell('genetic', :cure) }

      it { is_expected.to have_selector('p', text: 'You are not insured. Too bad. LOL!') }
    end
  end
end
