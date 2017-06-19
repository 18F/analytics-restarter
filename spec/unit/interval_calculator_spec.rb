require "spec_helper"

describe "IntervalCalculator" do
  describe "#calculate_interval" do
    it "calculates the interval correctly prior to 6:00 AM UTC" do
      # 2017/06/19 05:30:00 UTC
      run_time = Time.new(2017, 6, 19, 7, 30, 0, "+02:00")

      Timecop.freeze(run_time) do
        interval = IntervalCalculator.new.calculate_interval
        expect(interval).to eq(60 * 30) # 30 minutes
      end
    end

    it "calculates the interval correctly after 6:00 AM UTC" do
      # 2017/06/19 06:30:00 UTC
      run_time = Time.new(2017, 6, 19, 8, 30, 0, "+02:00")

      Timecop.freeze(run_time) do
        interval = IntervalCalculator.new.calculate_interval
        expect(interval).to eq(24 * 60 * 60 - 60 * 30) # 24 hours - 30 minutes
      end
    end
  end
end
