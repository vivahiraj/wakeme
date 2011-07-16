module  Wol

  require 'socket'

  def self.send(mac,bcast="255.255.255.255",port=40000)
    macb = [mac.gsub(/[\-\:]/, '')].pack('H*')
    packet = [0xff, 0xff, 0xff, 0xff, 0xff, 0xff].pack("C*")
    16.times {
      packet = packet + macb
    }
    sock = UDPSocket.open
    sock.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, 1)
    sock.connect(bcast,port)
    3.times {
      sock.send(packet, 0)
    }
    sock.close
    true
  end

end
