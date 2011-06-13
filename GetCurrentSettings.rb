#
#   GetCurrentSettings.rb
#
#   Created by Christian Frichot on 12/06/11.
#   Copyright 2011 __MyCompanyName__. All rights reserved.
#
include OSX
class GetCurrentSettings < NSObject
    ib_outlets :getCurrentSettingsButton, :outputTextBox


    ib_action :clickGetCurrentSettings do |sender|
      networkinterface = ChangeDNSConfiguration.instance.config['interface']
      @outputTextBox.setStringValue("Current DNS Settings:\n" + `networksetup -getdnsservers #{networkinterface}`)
    end
    
    def awakeFromNib
      networkinterface = ChangeDNSConfiguration.instance.config['interface']
      @outputTextBox.setStringValue("Current DNS Settings:\n" + `networksetup -getdnsservers #{networkinterface}`)
    end
end