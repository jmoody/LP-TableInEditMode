require 'calabash-cucumber/calabash_steps'

Then /^I should be able to find the device orientation$/ do
  orientation = backdoor("deviceOrientation", "")
  puts "the orientation = '#{orientation}'"
end


- (NSString *) deviceOrientation {
  UIApplication *app = [UIApplication sharedApplication];
  UIInterfaceOrientation orient =  app.statusBarOrientation;
  switch (orient) {
    case UIInterfaceOrientationLandscapeLeft:
      return @"landscape left";
      break;
    case  UIInterfaceOrientationLandscapeRight:
      return @"landscape right";
      break;
    case UIInterfaceOrientationPortrait:
      return @"portrait";
      break;
    case UIInterfaceOrientationPortraitUpsideDown:
      return @"portrait upside down";
      break;
    default:
      return @"unknown orientation";
      break;
  }
}
