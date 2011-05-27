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

#
# PREY CONFIGURATION FILE
#

default[:prey][:lang] = "en"
default[:prey][:auto_connect] = "n"
default[:prey][:check_url] = "http://control.preyproject.com"
default[:prey][:missing_status_code] = "404"
default[:prey][:post_method] = "http"

# http posting
default[:prey][:api_key] = "ADD_YOUR_API_KEY"
default[:prey][:device_key] = "ADD_YOUR_DEVICE_KEY"

# smtp posting
default[:prey][:mail_to] = 'mailbox@example.com'
default[:prey][:smtp_server] = 'smtp.gmail.com:587'
default[:prey][:smtp_user] = 'username@gmail.com'
default[:prey][:smtp_password] = 'password'
default[:prey][:mail_from] = 'Prey <no-reply@gmail.com>'
default[:prey][:mail_subject] = '[Prey] Status Report'

# additional http options
default[:prey][:curl_options] = '--compress'
default[:prey][:randomize_host_check] = 'n'
default[:prey][:extended_headers] = 'n'

# scp/sftp posting (EXPERIMENTAL!)
default[:prey][:ssh_options] = '-oStrictHostKeyChecking=no'
default[:prey][:scp_user] = 'username'
default[:prey][:scp_server] = 'my.server.com'
default[:prey][:scp_path] = '~'
default[:prey][:sftp_user] = 'username'
default[:prey][:sftp_server] = 'my.server.com'
default[:prey][:sftp_path] = '.'

# ssh tunnel (if no RSA keys)
default[:prey][:remote_tunnel_port] = ''
default[:prey][:remote_tunnel_host] = 'my.server.com'
default[:prey][:remote_tunnel_user] = 'username'
default[:prey][:remote_tunnel_pass] = 'password'

# Amazon S3 keys
default[:prey][:s3_access_key_id] = ''
default[:prey][:s3_secret_access_key] = ''
default[:prey][:s3_bucket_name] = ''
