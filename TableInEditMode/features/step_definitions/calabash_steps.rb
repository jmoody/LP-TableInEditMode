require 'calabash-cucumber/calabash_steps'

Then /^I should be able to find the device orientation$/ do
  orientation = backdoor("deviceOrientation", "")
  puts "the orientation = '#{orientation}'"
end

