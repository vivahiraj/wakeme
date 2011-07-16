class Machine < ActiveRecord::Base
  belongs_to :user

  def check_ip
    begin
      IPAddress::IPv4.new ip
    rescue
      return false
    end
    true
  end

  def check_mask
    begin
      IPAddress::IPv4.new "10.0.0.1/#{mask}"
    rescue
      return false
    end
    true
  end

  def check_mac
    if /^([0-9A-F]{2}:){5}[0-9A-F]{2}$/ =~ mac.upcase
      true
    else
      false
    end
  end

  def validate
    errors.add(:ip,"書式が不正です")   unless check_ip
    errors.add(:mask,"書式が不正です") unless check_mask
    errors.add(:mac,"書式が不正です")  unless check_mac
  end

  def before_save
    self.mac = self.mac.upcase
    ipa = IPAddress::IPv4.new "#{self.ip}/#{self.mask}"
    self.bcast = ipa.broadcast.address
  end

  def ping
    ret = `ping -c 1 #{ip}`
    if ret =~ /1 received/
      true
    else
      false
    end
  end

  def wake
    Wol.send(mac,bcast,configatron.wol_port)  
  end

end
