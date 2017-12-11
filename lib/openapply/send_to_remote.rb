require 'net/scp'
require 'net/ssh'

# CODE THAT TRANSFORMS STUDENT DATA
###################################

module SendToRemote

  # Send a string to convert to a file on a remote server
  # setup using ssh keys - not sure how to test - use at own risk
  #
  # === Attributes
  # * +data+ - object to be converted to a file on a remote system --
  # object can be a CSV String, Axlsx::Package or File object to be transfered
  # * +srv_hostname+ - fqdn or IP address of the remote host
  # * +srv_hostname+ - username to access the remote host
  # * +srv_path_file+ - full path and file name of the file on the remote host
  # * +file_permissions+ - permissions to make the file on the remote host (default is: 0750)
  # * +options+ - allow ssh start options to be passed in
  def send_data_to_remote_server( data, srv_hostname, srv_username,
                                  srv_path_file, srv_file_permissions="0750",
                                  ssl_options={}
                                )
    # be sure its a file type that can be sent
    return "Unrecognized Object"  unless known_transfer_object?(data)

    # Prep data as necessary for scp
    # https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch06s15.html
    # convert the string to a stringio object (which can act as a file)

    xfer = data                       if data.is_a? StringIO
    xfer = StringIO.new( data )       if data.is_a? String
    xfer = data                       if data.is_a? File

    # http://www.rubydoc.info/github/delano/net-scp/Net/SCP
    # send the stringio object to the remote host via scp
    Net::SCP.start(srv_hostname, srv_username, ssl_options) do |scp|
      # asynchronous upload; call returns immediately
      channel = scp.upload( xfer, srv_path_file )
      channel.wait
    end
    # ensure file has desired permissions (via remote ssh command)
    Net::SSH.start(srv_hostname, srv_username, ssl_options) do |ssh|
      # Capture all stderr and stdout output from a remote process
      output = ssh.exec!("chmod #{srv_file_permissions} #{srv_path_file}")
    end
  end
  alias_method :send_string_to_server_file, :send_data_to_remote_server

  # Check that the data to transfer is of a known data type
  #
  # === Attributes
  # * +data+ - is it an Axlsx::Package, Sting, StringIO or a File class?
  def known_transfer_object?( data )
    return true  if data.is_a? StringIO
    return true  if data.is_a? String
    return true  if data.is_a? File
    return false
  end

end
