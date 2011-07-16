class MachineController < ApplicationController
  before_filter :require_use_admin

  active_scaffold :machines do |config|
    config.label = "機器管理"

    config.columns = [:name,
                      :ip,
                      :mask,
                      :bcast,
                      :mac,
                      :created_at,
                      :updated_at]
    config.columns[:name].label    = "機器名"
    config.columns[:name].required = true
    config.columns[:ip].label         = "IPアドレス"
    config.columns[:ip].required      = true
    config.columns[:mask].label       = "サブネットマスク"
    config.columns[:mask].required    = true
    config.columns[:bcast].label      = "ブロードキャストアドレス"
    config.columns[:mac].label        = "MACアドレス"
    config.columns[:mac].required     = true
    config.columns[:mac].description  = "コロン(:)区切りで記述してください"
    config.columns[:created_at].label = "作成日時"
    config.columns[:updated_at].label = "更新日時"

    config.create.columns.exclude :bcast
    config.update.columns.exclude :bcast

    config.list.columns = [:name,:ip,:mask,:mac]
    config.list.sorting = { :ip => :asc }

    config.search.columns = [:name,:ip,:bcast,:mac]
  end

end
