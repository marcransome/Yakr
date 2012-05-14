#Yak

##Overview
Yak is a command-line tool for UNIX-like systems that allows you to forward command output (or arbitrary data) to a remote host over a network connection.  In fact, you can do some incredibly [fun things](http://marcransome.github.com/yak) with it.  It is built entirely in [Ruby](http://ruby-lang.org/), and is intended to be minimalist in its function.

##Caveats
Yak makes no attempt to validate the identity of the remote host, nor does it encrypt the data that it sends.  If you plan to use Yak to forward data over an open network then a [secure shell tunnel](http://en.wikipedia.org/wiki/Tunneling_protocol#Secure_shell_tunneling) is recommended.

##Prerequisites
A working Ruby installation (version 1.9 or greater) is required for Yak to work.  For more information refer to the [official installation procedure](http://www.ruby-lang.org/en/downloads/).

##Installation
Installing Yak is as easy as:

	$ gem install yak

##Using Yak
Yak functions as either a server or client; it can listen for an incoming connection, or attempt to establish an outgoing connection to another instance of Yak.

The following command-line arguments allow you to control which mode Yak should operate in:

	-c, --connect HOST               Specify the remote host to connect to
	-p, --port NUM                   Port number for outgoing connection
	-l, --listen NUM                 Port number for incoming connection

To launch a server instance of Yak specify a port number to listen for an incoming connection using the `-l  NUM` command-line argument (where _NUM_ is a valid port between 0 and 65535).  Yak will listen for incoming connections on the specified port, and output any data that it receives from a client once connected.  The following command would launch a Yak instance that listens for clients on port 2600:

	$ yak -l 2600

For Yak to operate as a client specify both a remote host and port number using the `-c HOST` and `-p NUM` arguments.  For example:

	$ yak -c remote.server.com -p 2600

Once a connection has been established, Yak reads data from the standard input stream (line by line) and forwards it to the remote instance.  Typing something and pressing the return key will send the data to the remote instance, which will in turn output the data to the screen.

Yak can forward input piped from other commands too:

	$ echo 'Hello World' | yak -c remote.server.com -p 2600

The server instance of Yak can be told to redirect the data it receives to a file (in this case a file named _output.txt_):

	$ yak -l 2600 > output.txt

Pretty easy, right?  For additional options type `yak --help`.

##Fun Stuff
To be added soon.

##License
Yak is free software, and you are welcome to redistribute it under certain conditions.  See the [GNU General Public License](http://www.gnu.org/licenses/gpl.html) for more details.

##Comments or suggestions?
Email me at [marc.ransome@fidgetbox.co.uk](marc.ransome@fidgetbox.co.uk) with bug reports, feature requests or general comments and follow [@marcransome](http://www.twitter.com/marcransome) for updates.
