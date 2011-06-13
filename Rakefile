require 'osx/cocoa' # dummy
require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'erb'
require 'pathname'

# Application own Settings
APPNAME   = "Quick DNS"
TARGET    = "#{APPNAME}.app"
VERSION   = "0.1"
RESOURCES = ['*.rb', '*.lproj', '*.yml']
PKGINC    = [TARGET, 'README.rdoc']
BUNDLEID  = "org.un-excogitate.changedns"
BUNDLESIG = "mate"

CLEAN.include ['**/.*.sw?', '*.dmg', TARGET, 'image', 'a.out', APPNAME, 'pkg']

# Tasks
task :default => [:test]

desc 'Create Application Budle and Run it.'
task :test => [TARGET] do
	sh %{open '#{TARGET}'}
end

desc 'Create .dmg file for Publish'
task :package => [:clean, 'pkg', TARGET] do
	name = "#{APPNAME}.#{VERSION}"
	sh %{
	mkdir image
	cp -r #{PKGINC.join(' ')} image
	}
	puts 'Creating Image...'
	sh %{
	hdiutil create -volname #{name} -srcfolder image #{name}.dmg
	rm -rf image
	mv #{name}.dmg pkg
	}
end

# File tasks
desc 'Make executable Application Bundle'
file TARGET => [:clean, APPNAME] do
	sh %{
	mkdir -p "#{APPNAME}.app/Contents/MacOS"
	mkdir    "#{APPNAME}.app/Contents/Resources"
	cp -rp #{RESOURCES.join(' ')} "#{APPNAME}.app/Contents/Resources"
	cp '#{APPNAME}' "#{APPNAME}.app/Contents/MacOS"
	echo #{VERSION} > "#{APPNAME}.app/Contents/Resources/VERSION"
	}
	File.open("#{APPNAME}.app/Contents/Info.plist", "w") do |f|
		f.puts ERB.new(File.read("Info.plist.erb")).result
	end
end

file APPNAME => ['main.m'] do
	# Universal Binary
	sh %{gcc -arch i386 -Wall -lobjc -framework RubyCocoa main.m -o '#{APPNAME}'}
end

directory 'pkg'

