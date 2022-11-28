# Yakr

## Overview
Yakr is a command-line tool for UNIX-like systems that allows you to forward command output or arbitrary data to a remote host via a TCP/IP network connection.  In fact, you can do some incredibly fun things with it.  It is built entirely in [Ruby](http://ruby-lang.org/), and is intended to be minimalist in its function.

## Caveats
Yakr makes no attempt to validate the identity of the remote host, nor does it encrypt the data that it sends.  If you plan to use Yakr to forward data over an open network then a [secure shell tunnel](http://en.wikipedia.org/wiki/Tunneling_protocol#Secure_shell_tunneling) is highly recommended.

## Prerequisites
A working Ruby installation (version 1.9 or greater) is required for Yakr to work.  For more information refer to the [official installation procedure](http://www.ruby-lang.org/en/downloads/).

## Installation
Installing Yakr is as easy as:

	$ gem install yakr

## Using Yakr
Yakr functions as either a server or client; it can listen for an incoming connection, or attempt to establish an outgoing connection to another instance of Yakr.

The following command-line arguments allow you to control which mode Yakr should operate in:

	-c, --connect HOST               Specify the remote host to connect to
	-p, --port NUM                   Port number for outgoing connection
	-l, --listen NUM                 Port number for incoming connection

To launch a server instance of Yakr specify a port number to listen for an incoming connection using the `-l  NUM` command-line argument (where _NUM_ is a valid port between 0 and 65535).  Yakr will listen for incoming connections on the specified port, and output any data that it receives from a client once connected.  The following command would launch a Yakr instance that listens for clients on port 2600:

	$ yakr -l 2600

For Yakr to operate as a client and connect to a remote Yakr instance you'll need to specify both a host and port number using the `-c HOST` and `-p NUM` arguments.  For example:

	$ yakr -c remote.server.com -p 2600

Once a connection has been established, Yakr reads data from the standard input stream (line by line) and forwards it to the remote instance.  Typing something and pressing the return key will send the data to the remote instance, which will in turn output the data to the screen.

Yakr can forward input piped from other commands too:

	$ echo 'Hello World' | yakr -c remote.server.com -p 2600

The server instance of Yakr can be told to redirect the data it receives to a file (in this case a file named _output.txt_):

	$ yakr -l 2600 > output.txt

For additional options type `yakr --help`.

## Fun Stuff
It's possible to mimic a simple chat interface using a split terminal window (courtesy of the wonderful [iTerm 2](http://www.iterm2.com)):

<img src="https://www.fidgetbox.co.uk/github/yakr.png" alt="Split terminal conversation" width="762">

The top pane shows the output of a local instance of Yakr with a remote client connected. This acts as our incoming chat window. The bottom pane shows another local instance of Yakr connected to the remote system as a client. This acts as our outgoing message window. Crude, but perfectly usable.

## License
Yakr is free software, and you are welcome to redistribute it under certain conditions.  See the [GNU General Public License](http://www.gnu.org/licenses/gpl.html) for more details.

## Contact
Email me at [marc.ransome@fidgetbox.co.uk](mailto:marc.ransome@fidgetbox.co.uk) or [create an issue](https://github.com/marcransome/Yakr/issues).
