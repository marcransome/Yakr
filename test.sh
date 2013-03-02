#!/bin/bash
#
#  test.sh
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

version_from_gemspec=$( grep 's.version' yakr.gemspec | cut -c 16-20 )
gem_file="yakr-$version_from_gemspec.gem"

echo "Removing outdated gem files.."
rm *.gem

echo "Uninstalling previous versions.."
gem uninstall -a -x yakr

echo "Building gem.."
gem build yakr.gemspec

echo "Installing gem file.."
gem install $gem_file
