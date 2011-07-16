class WelcomeController < ApplicationController
  skip_before_filter :authorize ,:only=>[:notlogin]
  
  def index
  end

  def notlogin
    render(:layout => "notlogin")
  end

end
