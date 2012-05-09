#!/usr/bin/env ruby
# A script that will pretend to resize a number of images
require 'rubygems'
require 'mechanize'
require 'hpricot'
require 'optparse'

# This hash will hold all of the options
# parsed from the command-line by
# OptionParser.
options = {}

optparse = OptionParser.new do|opts|
  # Set a banner, displayed at the top
  # of the help screen.
  opts.banner = "Usage: check_xpath.rb -u \"http://site.com/doc.html\" -x \"/html/body/blockquote/p[7]\""

  options[:url] = nil
  opts.on( '-u', '--url URL', 'Download HTML from URL' ) do |url|
    options[:url] = url
  end

  options[:xpath] = nil
  opts.on( '-x', '--xpath XPATH', 'Print out text corresponding to XPATH' ) do |xpath|
    options[:xpath] = xpath
  end

  # This displays the help screen, all programs are
  # assumed to have this option.
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

# Parse the command-line. Remember there are two forms
# of the parse method. The 'parse' method simply parses
# ARGV, while the 'parse!' method parses ARGV and removes
# any options found there, as well as any parameters for
# the options. What's left is the list of files to resize.
optparse.parse!

if options[:url].nil?
	puts "url is required"
	Process.exit
end

if options[:xpath].nil?
	puts "xpath is required"
	Process.exit
end

agent = Mechanize.new
page = agent.get(options[:url])

doc = Hpricot(page.content)

puts (doc/options[:xpath])[0].innerHTML

