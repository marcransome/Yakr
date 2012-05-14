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
require 'timeout'

class Yak
	
	VERSION = "0.1"
	
	# short usage banner
	@simple_usage = "Use `#{File.basename($0)} --help` for available options."
	@server = nil
	@line = nil
	
	def self.run
		
		# test for zero arguments
		if ARGV.empty? then
			puts @simple_usage
			exit 1
		end
		
		# start processing command line arguments
		begin
			options = OptionReader.parse(ARGV)
		rescue OptionParser::InvalidOption => t
			puts t
			puts @simple_usage
			exit
		rescue OptionParser::MissingArgument => m
			puts m
			puts @simple_usage
			exit
		end
		
		# ensure host argument is specified if a port is specified
		if options.connect_port.any? and !options.connect_host.any?
			puts "host connect: no host specified"
			puts @simple_usage
			exit 1
		end
		
		if options.connect_host.any? and !options.connect_port.any?
			puts "host connect: no port specified"
			puts @simple_usage
			exit 1
		end
		
		# validate host argument
		if options.connect_host.any?
			# TODO
		end
		
		# validate host port
		if options.connect_port.any?
			if options.connect_port.first.to_i > 0 and options.connect_port.first.to_i < 65535
				# valid port provided
				
			else
				puts "invalid port: #{options.connect_port.first.to_s}"
				puts @simple_usage
				exit 1
			end
		end
		
		# validate listen port
		if options.connect_port.any?
			if options.connect_port.first.to_i > 0 and options.connect_port.first.to_i < 65535
				# valid port provided
				
			else
				puts "invalid port: #{options.connect_port.first.to_s}"
				puts @simple_usage
				exit 1
			end
		else
			options.connect_port << "4000"
		end
	
		# assume connection mode wherever a host has been specified,
		# otherwise listen for incoming connections
		if options.connect_host.any?
			connect(options.connect_host.first, options.connect_port.first.to_i)
		else
			listen(options.listen_port.first.to_i, options.limit_lines.to_i)
		end
	end

	def self.connect(host, port)
		
		begin
			timeout(30) do
				# establish connection
				@server = TCPSocket.open(host, port)
				
				# wait for server response
				@line = @server.readline
			end
		
			if @line.start_with?('yak=>')
				
				# read from standard input and send
				# text line by line to server
				STDIN.each do |str|
					#str.chomp!
					@server.puts "#{str}"
				end
			else
				puts "host connect: unexpected server response"
				puts @simple_usage
				exit 1
			end
		
		rescue Interrupt
			puts "\nCancelled, exiting.."
			exit 1
		rescue Timeout::Error => ex
			puts "host connect: timed out"
			puts @simple_usage
			exit 1
		rescue
			puts "host connect: unable to connect"
			puts @simple_usage
			exit 1
		end		
	end
	
	def self.listen(port, lines_arg)
		begin
			@server = TCPServer.open(port)
			loop do
				client = @server.accept
				client.puts "yak=>version:#{VERSION}"

				max_lines = lines_arg
				
				client.each do |str|
					
					exit 0 if max_lines == 0 and lines_arg > 0
					
					#str.chomp!
					puts "#{str}"
					
					# decrement line counter
					max_lines -= 1
				end
			end
		rescue Interrupt
			puts "\nCancelled, exiting.."
			exit 1
		rescue SystemExit
		rescue
			puts "listen server: unable to start"
			exit 1
		end
	end
end
