require 'spec_helper'

class DummyCell < Cell::Base
  def show
    "<p>I'm a Dummy.</p>"
  end

  def update(what)
    "Updating #{what}."
  end
end

RSpec.describe DummyCell, type: :cell do
  context 'cell rendering' do
    context 'rendering show' do
      subject { render_state(:show) }

      it { is_expected.to have_selector('p', text: 'I\'m a Dummy.') }
    end

    context 'rendering update' do
      subject { render_cell('dummy', :update, 'account') }

      it { is_expected.to have_selector('p', text: 'Updating account.') }
    end
  end
end
