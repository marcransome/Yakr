#
#  yakr.rb
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

require 'yakr/optionreader'
require 'optparse'
require 'ostruct'
require 'socket'
require 'timeout'

class Yakr

  VERSION = "0.2.4"
  REQUIRE_SERVER = 0.1
  USAGE_BANNER = "Use `#{File.basename($0)} --help` for available options."

  @server = nil
  @line = nil

  def self.run

    # test for zero arguments
    if ARGV.empty? then
      self.exit_with_banner(1)
    end

    # start processing command line arguments
    begin
      options = OptionReader.parse(ARGV)
    rescue OptionParser::InvalidOption => t
      puts t
      self.exit_with_banner(1)
    rescue OptionParser::MissingArgument => m
      puts m
      self.exit_with_banner(1)
    end

    # validate mode options
    if (options.connect_host or options.connect_port) and
       (options.listen_port or options.limit_lines) then
      puts "mode options: specify either listen or connect options"
      self.exit_with_banner(1)
    elsif not (options.connect_host or options.listen_port)
      puts "mode options: specify listen or connect options"
      self.exit_with_banner(1)
    end

    # validate server options
    if options.connect_port and not options.connect_host
      puts "host connect: no host specified"
      self.exit_with_banner(1)
    end

    if options.connect_host and not options.connect_port
      puts "host connect: no port specified"
      self.exit_with_banner(1)
    end

    # validate connection port
    if options.connect_port
      if not (options.connect_port.to_i > 0 and options.connect_port.to_i <= 65535)
        puts "invalid port: #{options.connect_port.to_s}"
        self.exit_with_banner(1)
      end
    end

    # validate listen port
    if options.listen_port
      if not (options.listen_port.to_i > 0 and options.listen_port.to_i <= 65535)
        puts "invalid port: #{options.listen_port.to_s}"
        self.exit_with_banner(1)
      end
    end

    # validate line limit
    if options.limit_lines and not options.limit_lines.to_i > 0
        puts "invalid max lines: #{options.limit_lines}"
        self.exit_with_banner(1)
    end

    if options.connect_host
      connect(options.connect_host, options.connect_port.to_i)
    else
      listen(options.listen_port.to_i, options.limit_lines.to_i)
    end
  end

  def self.connect(host, port)

    begin
      timeout(20) do

        puts "Attempting connection.."

        # establish connection
        @server = TCPSocket.open(host, port)

        # wait for server response
        @line = @server.readline
      end

      if @line.start_with?('yakr=>')

        puts "yakr: connected to #{host} on port #{port}"

        # read from standard input and send
        # text line by line to server
        STDIN.each do |str|
          @server.puts "#{str}"
        end
      else
        puts "host connect: unexpected server response"
        self.exit_with_banner(1)
      end

    rescue Interrupt
      puts "\nCancelled, exiting.."
      exit 1
    rescue Timeout::Error => ex
      puts "host connect: timed out"
      self.exit_with_banner(1)
    rescue => e
      puts "host connect: unable to connect #{e}"
      self.exit_with_banner(1)
    ensure
      @server.close unless @server.nil?
    end
  end

  def self.listen(port, max_lines)
    begin
      limit_output = true if max_lines > 0
      @server = TCPServer.open(port)
      loop do
        client = @server.accept
        client.puts "yakr=>version:#{VERSION}"
        client.each do |str|
          exit 0 if max_lines <= 0 and limit_output
          puts "#{str}"
          max_lines -= 1 if limit_output
        end
      end
    rescue Interrupt
      puts "\nCancelled, exiting.."
      exit 1
    rescue SystemExit
    rescue
      puts "listen server: unable to start"
      exit 1
    ensure
      @server.close unless @server.nil?
    end
  end

  def self.exit_with_banner(x)
    puts USAGE_BANNER
    exit x
  end
end
