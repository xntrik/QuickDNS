#!/usr/bin/ruby
require 'optparse'
require 'changednsconfiguration'

options = {} #Command line options
networkinterface = ChangeDNSConfiguration.instance.config['interface'] #Read the config for the network interface

#Parse command line options
optparse = OptionParser.new do |opts|
	opts.banner = "Usage: changedns.rb [options]"

	options[:service] = nil
	opts.on('-s', '--service SERVICE', 'Set AirPort DNS settings to this service') do |service|
		options[:service] = service
	end

	opts.on('-l', '--list', 'List the available DNS services') do
		ChangeDNSConfiguration.instance.config['services'].each do |name,ports|
			puts "#{name} - #{ports}"
		end
		exit
	end

	opts.on('-d', '--dns', 'List the current DNS settings applied to your AirPort') do
		cmd = "networksetup -getdnsservers #{networkinterface}"
		system cmd
		exit
	end

	opts.on('-h', '--help', 'Displays this screen') do
		puts opts
		exit
	end
end

optparse.parse!

if options[:service].nil?
	puts "Try the -h option"
	exit
else
	dnsstring = ChangeDNSConfiguration.instance.config['services'][options[:service]]
	cmd = "networksetup -setdnsservers #{networkinterface} #{dnsstring}"
	system cmd
end
