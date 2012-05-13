#
#  yak.rb
#
#  Copyright (c) 2012, Marc Ransome <marc.ransome@fidgetbox.co.uk>
#
#  This file is part of Yak.
#
#  Yak is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Yak is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Yak.  If not, see <http://www.gnu.org/licenses/>.
#

require 'yak/optionreader'
require 'optparse'
require 'ostruct'
require 'socket'

class Yak
	
	def self.run
		
		# start processing command line arguments
		begin
		
			# short usage banner
			simple_usage = "Use `#{File.basename($0)} --help` for available options."
		
			# test for zero arguments
			if ARGV.empty? then

				# TODO default to listen mode
				puts "Undefined"
				exit
			end
			
			# parse command-line arguments
			options = OptionReader.parse(ARGV)
			
		rescue OptionParser::InvalidOption => t
			puts t
			puts simple_usage
			exit
		rescue OptionParser::MissingArgument => m
			puts m
			puts simple_usage
			exit
		end
	end

	def self.msgRemote
		# read from standard input
		STDIN.each do |str|
			str.chomp!
			
			# TODO
			puts "#{str}"
		end
	end

end

Yak.run