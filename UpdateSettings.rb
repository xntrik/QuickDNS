#
#   UpdateSettings.rb
#
#   Created by Christian Frichot on 13/06/11.
#   Copyright 2011 __MyCompanyName__. All rights reserved.
#
include OSX
class UpdateSettings < NSObject
    ib_outlets :dropdowner, :outputTextBox

    ib_action :updateButton do |sender|
      networkinterface = ChangeDNSConfiguration.instance.config['interface']
      cmd = "networksetup -setdnsservers #{networkinterface} " + ChangeDNSConfiguration.instance.config['services'][@dropdowner.stringValue.to_s] 
      system cmd
      @outputTextBox.setStringValue("Current DNS Settings:\n" + `networksetup -getdnsservers #{networkinterface}`)
    end
    
    def awakeFromNib
      ChangeDNSConfiguration.instance.config['services'].each do |name,ports|
        @dropdowner.addItemWithObjectValue(name)
      end
      @dropdowner.selectItemAtIndex(0)
    end
end