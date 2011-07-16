# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def japan_date(record)
    record[:created_at].strftime("%Y-%m-%d %H:%M:%S")
  end

  def created_at_column(record)
    japan_date(record)
  end

  def updated_at_column(record)
    japan_date(record)
  end

end
