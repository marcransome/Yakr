#
#  optionreader.rb
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

class OptionReader

	def self.parse(args)

		options = OpenStruct.new
		options.output = []
		options.verbose = false
		options.hide_title = false
		options.hide_artist = false
		options.hide_album = false
		options.hide_location = false
		options.hide_tracknum = false
		options.connect_host = []
		options.connect_port = []
		options.listen_port = []

		opts = OptionParser.new do |opts|
			opts.banner = "Usage: #{File.basename($0)} [-c HOST -p PORT] | [-l PORT]"

			opts.separator ""			

			opts.separator "#{File.basename($0).capitalize} is either listening for a remote connection or connected"
			opts.separator "to a remote host.  These options are mutually exclusive."

			opts.separator ""
			opts.separator "Connection options:"

			opts.on("-c", "--connect HOST", "Specify the remote host to connect to") do |host|
				options.connect_host << host
			end

			opts.on("-p", "--port NUM", "Port number for outgoing connection") do |port|
				options.connect_port << port
			end

			opts.on("-l", "--liste NUM", "Port number for incoming connection") do |port|
				options.listen_port << port
			end

			opts.separator ""
			opts.separator "Misc options:"

			opts.on("-v", "--version", "Display version information") do
				puts "#{File.basename($0).capitalize} 0.1.0 Copyright (C) 2012 Marc Ransome <marc.ransome@fidgetbox.co.uk>"
				puts "This program comes with ABSOLUTELY NO WARRANTY, use it at your own risk."
				puts "This is free software, and you are welcome to redistribute it under"
				puts "certain conditions; see LICENSE.txt for details."
				exit
			end

			opts.on_tail("-h", "--help", "Show this screen") do
				puts opts
				exit
			end
		end

		# parse then remove the remaining arguments
		opts.parse!(args)

		# return the options array
		options

	end # def self.parse(args)

end # class OptionReader
