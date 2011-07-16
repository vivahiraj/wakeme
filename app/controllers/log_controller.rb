class LogController < ApplicationController
  before_filter :require_use_admin

  active_scaffold :logs do |config|
    config.label = "アクセスログ確認"
    config.actions.exclude :create, :update, :delete

    config.columns = [:login,
                      :ip,
                      :url,
                      :param,
                      :created_at]

    config.columns[:login].label         = "ログインアカウント"
    config.columns[:ip].label         = "アクセス元IP"
    config.columns[:url].label  = "アクセスURL"
    config.columns[:param].label = "パラメータ"
    config.columns[:created_at].label   = "作成日時"

    config.list.columns.exclude :param, :ip
    config.list.sorting = [{:created_at => :DESC}]
    config.list.per_page = 100

    config.search.columns << [:login,:ip,:url,:param,:created_at]
  end

end
