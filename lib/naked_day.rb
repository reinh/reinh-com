module Webby::Helpers::NakedDay
  def naked_day?
    day=9; month=4
    start = Time.utc(Time.now.year, month, day) - 12 * 60 * 60
    stop = Time.utc(Time.now.year, month, day) + 36 * 60 * 60
    now = Time.now.utc

    now > start && now < stop
  end
end

Webby::Helpers.register(Webby::Helpers::NakedDay)
