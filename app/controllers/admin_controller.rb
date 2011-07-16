class AdminController < ApplicationController
  before_filter :require_use_admin

  active_scaffold :users do |config|
    config.label = "利用者管理"

    config.action_links.add 'log' ,:label => 'アクセスログ',:controller => 'log',:action => 'index',:page => true

    config.columns = [:login_name,
                      :admin_flag,
                      :created_at,
                      :updated_at]

    config.columns[:login_name].label    = "アカウント"
    config.columns[:login_name].required = true
    config.columns[:admin_flag].label    = "管理者権限"
    config.columns[:admin_flag].form_ui  = :checkbox
    config.columns[:created_at].label    = "作成日時"
    config.columns[:updated_at].label    = "更新日時"
    config.columns[:machines].search_sql = "concat(machines.name,' ',machines.ip,' ',machines.mac)"

    config.list.columns = [:login_name,:admin_flag]
    config.list.sorting = { :login_name => :asc }

    config.search.columns = [:login_name,:machines]

    config.nested.add_link("対象機器", :machines)
  end

end
