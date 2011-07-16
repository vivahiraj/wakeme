class WakeController < ApplicationController
  active_scaffold :machines do |config|
    config.label = "機器管理"

    config.action_links.add 'wake', :label => '起動', :type => :member
    config.action_links.add 'ping', :label => 'PING', :type => :member

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

  def ping
    @machine = Machine.find(params[:id])
    @alive   = @machine.ping
    render(:layout => "ajax_box")
  end

  def wake
    @machine = Machine.find(params[:id])
    @machine.wake
    render(:layout => "ajax_box")
  end

  protected

  def conditions_for_collection
    ["user_id = ?", @user_id]
  end

  def before_create_save(record)
    record.user_id = @user_id
  end

  def before_update_save(record)
    record.user_id = @user_id
  end

end
