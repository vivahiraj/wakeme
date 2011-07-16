class User < ActiveRecord::Base
  has_many :machines

  def to_label
    "#{login_name}"
  end

end
