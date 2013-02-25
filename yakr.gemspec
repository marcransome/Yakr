#
#  yakr.gemspec
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

Gem::Specification.new do |s|
	s.name			= 'yakr'
	s.version		= '0.2.3'
	s.date			= '2013-02-25'
	s.summary		= 'TCP/IP output tool'
	s.description	= 'Yakr is a minimalist network tool for forwarding command output or arbitrary data to a remote host.'
	s.authors		= ["Marc Ransome"]
	s.email			= 'marc.ransome@fidgetbox.co.uk'
	s.files			= `git ls-files`.split("\n")
	s.executables		<< 'yakr' 
	s.homepage		= 'http://marcransome.github.com/Yakr'
	s.license		= 'GPL-3'
end
