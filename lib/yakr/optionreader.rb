#
#  optionreader.rb
#
#  Copyright (c) 2012, Marc Ransome <marc.ransome@fidgetbox.co.uk>
#
#  This file is part of Yakr.
#
#  Yakr is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Yakr is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Yakr.  If not, see <http://www.gnu.org/licenses/>.
#

class OptionReader

  def self.parse(args)

    options = OpenStruct.new

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: #{File.basename($0)} -c HOST -p PORT | -l PORT [-m NUM]"

      opts.separator ""
      opts.separator "Client mode options:"

      opts.on("-c", "--connect HOST", "Specify the remote host to connect to") do |host|
        options.connect_host = host
      end

      opts.on("-p", "--port PORT", "Port number for outgoing connection") do |port|
        options.connect_port = port
      end

      opts.separator ""
      opts.separator "Server mode options:"

      opts.on("-l", "--listen PORT", "Port number for incoming connection") do |port|
        options.listen_port = port
      end

      opts.on("-m", "--max NUM", "Limit output to NUM lines, then exit") do |lines|
        options.limit_lines = lines
      end

      opts.separator ""
      opts.separator "Misc options:"

      opts.on("-v", "--version", "Display version information") do
        puts "#{File.basename($0).capitalize} #{Yakr::VERSION} Copyright (C) 2012 Marc Ransome <marc.ransome@fidgetbox.co.uk>"
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

