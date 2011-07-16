# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :authorize
  after_filter  :write_log

  protected
  def authorize
    auth_ret = true
    if session[:user].nil?
      if ENV['RAILS_ENV'] == "development"
        auth_ret = false
        authenticate_or_request_with_http_basic do |user, pass|
          request.env['REMOTE_USER'] = user
          auth_ret = true
          true
        end
      end
      login = request.env['REMOTE_USER']
      unless configatron.login_erase.blank?
        login.sub!(configatron.login_erase,"") unless login.nil?
      end
      session[:user] = User.find(:first,:conditions=>["login_name = ?",login])
    end
    if session[:user]
      @user_id     = session[:user].id
      @login_name  = session[:user].login_name
      @login_admin = session[:user].admin_flag
    end
    if auth_ret and session[:user].nil?
      redirect_to :controller => 'welcome', :action => 'notlogin'
    end
  end

  def require_use_admin
    unless @login_admin
      redirect_to :controller => 'welcome', :action => 'notlogin', :login => @login_name
    end
  end

  def write_log
    log       = Log.new
    log.login = session[:user].login_name if session[:user]
    log.ip    = request.remote_ip
    log.url   = request.url
    vals = ""
    params.each {|key,value|
      vals = vals + key + "=" + value + " " if value.class == String
    }
    log.param = vals
    log.save
  end

end
