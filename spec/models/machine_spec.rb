require 'spec_helper'

describe Machine do
  fixtures :users,:machines

  before(:each) do
    valid_attributes = {
      :user_id => 1,
      :name    => "test",
      :ip      => "192.168.0.1",
      :mask    => "255.255.255.0",
      :mac     => "00:11:22:33:44:aa",
    }
    @m = Machine.create!(valid_attributes)
  end

  describe "check_ip" do
    it "正常なIPアドレスの場合trueを返す" do
      @m.check_ip.should be_true
    end
    it "異常なIPアドレスの場合falseを返す" do
      @m.ip = "a"
      @m.check_ip.should be_false
      @m.ip = "192.168.0.256"
      @m.check_ip.should be_false
    end
  end

  describe "check_mask" do
    it "正常なサブネットマスクの場合trueを返す" do
      @m.check_mask.should be_true
      @m.mask = "24"
      @m.check_mask.should be_true
    end
    it "異常なサブネットマスクの場合falseを返す" do
      @m.mask = "a"
      @m.check_mask.should be_false
      @m.mask = "255.255.0.1"
      @m.check_mask.should be_false
    end
  end

  describe "check_mac" do
    it "正常なMACアドレスの場合trueを返す" do
      @m.check_mac.should be_true
      @m.mac = "AA:BB:CC:DD:EE:FF"
      @m.check_mac.should be_true
      @m.mac = "aa:bb:cc:dd:ee:ff"
      @m.check_mac.should be_true
    end
    it "異常なMACアドレスの場合falseを返す" do
      @m.mac = "1AA:BB:CC:DD:EE:FF"
      @m.check_mac.should be_false
      @m.mac = "AA:BB:CC:DD:EE:FF1"
      @m.check_mac.should be_false
      @m.mac = "AA:BB:CC:DD:EE:FG"
      @m.check_mac.should be_false
      @m.mac = "AA:BB:CC:DD:E:F"
      @m.check_mac.should be_false
      @m.mac = "AA-BB:CC:DD:EE:FF"
      @m.check_mac.should be_false
      @m.mac = "AA:BB:CC:DD:EE"
      @m.check_mac.should be_false
      @m.mac = "AA:BB:CC:DD:EE:FF:FF"
      @m.check_mac.should be_false
    end
  end

  describe "validate" do
    it "正常なデータの場合は登録できる" do
      @m.should be_valid
    end
    it "IPアドレスのチェックが行われ、不正な場合はできない" do
      @m.ip = "a"
      @m.should_not be_valid
    end
    it "サブネットマスクのチェックが行われ、不正な場合はできない" do
      @m.mask = "a"
      @m.should_not be_valid
    end
    it "MACアドレスのチェックが行われ、不正な場合はできない" do
      @m.mac = "a"
      @m.should_not be_valid
    end
  end

  describe "before_save" do
    it "MACアドレスは大文字に変更させる" do
      @m.mac.should == "00:11:22:33:44:AA"
    end
    it "ブロードキャストアドレスがセットされる" do
      @m.bcast.should == "192.168.0.255"
    end
  end

  describe "ping" do
    it "pingが疎通すればtrueを返す" do
      @m.ip = "127.0.0.1"
      @m.ping.should be_true
    end
    it "pingが疎通しなければfalseを返す" do
      @m.ip = "192.168.5.100"
      @m.ping.should be_false
    end
  end

  describe "wake" do
    it "実行されてtrueを返す" do
      m = machines(:m1)
      m.wake.should be_true
    end
  end

end
