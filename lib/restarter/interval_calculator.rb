##
# 6:00 AM UTC is 2:00 AM or 1:00 AM ET depending on DST
#
RESTART_HOUR_UTC = 6

module Restarter
  class IntervalCalculator
    def calculate_interval
      next_restart_time - Time.now
    end

    private

    def next_restart_time
      current_time_utc = Time.now.utc
      restart_time_today = Time.new(
        current_time_utc.year,
        current_time_utc.month,
        current_time_utc.day,
        RESTART_HOUR_UTC,
        0,
        0,
        "+00:00",
      )
      if restart_time_today - current_time_utc > 0
        restart_time_today
      else
        restart_time_today + 24 * 60 * 60
      end
    end
  end
end
