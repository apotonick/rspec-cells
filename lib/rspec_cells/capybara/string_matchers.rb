# This includes a backported version of the Capybara string matchers David Chelimsky
# is preparing in https://github.com/dchelimsky/capybara/tree/rspec-matchers
#
# Looks like the string matchers will be included in Capybara 0.4.2 if the feature is ready.
#
# The branch have not being merged into master because it's missing support for the capybara
# page object.
#
# When we test a rendered cell with the `render_cell` method we get an ActionView::OutputBuffer
# instance, it is in short, a safe version of String, so we are testing a String, not a capybara
# page object. So the matchers are OK and the missing features won't bother us.
#
# Follow up in http://groups.google.com/group/ruby-capybara/browse_thread/thread/c8adaa8f750b1020
module RSpecCells
  module Capybara
    module StringMatchers
      extend ::RSpec::Matchers::DSL

      %w[css xpath selector].each do |type|
        matcher "have_#{type}" do |*args|
          match_for_should do |string|
            ::Capybara::string(string).send("has_#{type}?", *args)
          end

          match_for_should_not do |string|
            ::Capybara::string(string).send("has_no_#{type}?", *args)
          end

          failure_message_for_should do |string|
            "expected #{type} #{formatted(args)} to return something from:\n#{string}"
          end

          failure_message_for_should_not do |string|
            "expected #{type} #{formatted(args)} not to return anything from:\n#{string}"
          end

          def formatted(args)
            args.length == 1 ? args.first.inspect : args.inspect
          end
        end
      end

    end
  end
end
