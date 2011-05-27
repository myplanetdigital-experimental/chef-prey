#
# Cookbook Name:: prey
# Recipe:: default
#
# Copyright 2011, Myplanet Digital
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

case node[:os]
when "linux"
  if node[:platform] === "ubuntu" && node[:platform_version] >= 11.04
    require_recipe "apt"
    package "prey" do
      action :install
    end
  else
    case node[:platform]
    when "ubuntu"
      remote_file "#{Chef::Config[:file_cache_path]}/prey_0.5.3-ubuntu2_all.deb" do
        source "http://preyproject.com/releases/0.5.3/prey_0.5.3-ubuntu2_all.deb"
        checksum "a51d1cc25a359a9d333c1f6731dc80c9"
        action :create_if_missing
      end

      package "prey" do
        source "#{Chef::Config[:file_cache_path]}/prey_0.5.3-ubuntu2_all.deb"
      end

    # All other linux distros
    else
      require_recipe "cron"
      package "wget" do
        action :install
      end
      package "curl" do
        action :install
      end
      package "scrot" do
        action :install
      end
      package "imagemagick" do
        action :install
      end
      if node[:platform] === "fedora"
        package "xawtv" do
          action :install
        end
      else
        package "streamer" do
          action :install
        end
      end
      package "perl" do
        action :install
      end
      remote_file "#{Chef::Config[:file_cache_path]}/prey-0.5.3-linux.zip" do
        source "http://preyproject.com/releases/0.5.3/prey-0.5.3-linux.zip"
        checksum "28192a8ccf5172d7ef011aec02acec8e"
        action :create_if_missing
      end

      directory "/usr/share/prey" do
        recursive true
        action :create
      end

      bash "build prey" do
        cwd Chef::Config[:file_cache_path]
        code <<-EOH
        tar -xvf prey-0.5.3-linux.zip -C /usr/share/prey
        EOH
      end

      template "/usr/share/prey/config" do
        source "config.erb"
        action :create
      end

      cron "crontab for prey check-in" do
        minute "*/20"
        command "/usr/share/prey/prey.sh > /var/log/prey.log"
      end
    end
  end
when "windows"
  remote_file "#{Chef::Config[:file_cache_path]}/prey-0.5.3-win.exe" do
    source "http://preyproject.com/releases/0.5.3/prey-0.5.3-win.exe"
    checksum "c8fe5d290124df06f2dec3e3809fffbd"
    action :create_if_missing
  end
  remote_file "#{Chef::Config[:file_cache_path]}/prey-win-batch-install.bat" do
    source "http://preyproject.com/releases/prey-win-batch-install.bat"
    action :create
  end
  execute "install prey on windows" do
    cwd #{Chef::Config[:file_cache_path]}
    code <<-EOH
    prey-win-batch-install.bat #{node[:prey][:api_key]}
    EOH
  end
when "mac_os_x"
  require_recipe "dmg"
  dmg_package "Prey" do
    volumes_dir "Prey Installer"
    source "http://preyproject.com/releases/0.5.3/prey-0.5.3-mac.dmg"
    checksum "877c3b6bea8923d2ca403c6f447fb6ae"
    action :install
  end
end

