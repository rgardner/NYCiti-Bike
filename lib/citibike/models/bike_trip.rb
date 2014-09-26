require "csv"
require "date"

module CitiBike

  # Represents a Citi Bike trip.
  class BikeTrip
    DATE_FORMAT = "%m/%d/%Y %l:%M:%S %p"         # citibike format as of 4/17/19
    DURATION_REGEX = /(\d{1,2}) min (\d{1,2}) s/ # citibike format as of 4/17/19
    SECS_PER_MIN = 60

    attr_accessor :start_station, :start_time, :end_station, :end_time,
                  :duration

    def initialize(start_time, start_station, end_time, end_station, duration)
      @start_time = parse_time(start_time)
      @start_station = start_station
      @end_time = parse_time(end_time)
      @end_station = end_station
      @duration = parse_duration(duration)
    end

    # Sets duration of trip in seconds.
    #
    # @param duration [Integer, String] e.g. 963 or 16 min 23 s
    def duration=(duration)
      case duration
      when Integer
        @duration = duration
      when String
        @duration = parse_duration(duration)
      end
    end

    def self.csv_header
      CSV.generate(quote_empty: false) do |csv|
        csv << ["Start Station", "Start Time", "End Station", "End Time", "Duration (seconds)"]
      end
    end

    def to_csv
      CSV.generate(quote_empty: false) do |csv|
        csv << [@start_station, @start_time, @end_station, @end_time, @duration]
      end
    end

    private

    def parse_time(time)
      begin
        DateTime.strptime(time, DATE_FORMAT)
      rescue ArgumentError
        nil
      end
    end

    def parse_duration(duration)
      match = DURATION_REGEX.match(duration)
      if not match.nil?
        match[1].to_i * SECS_PER_MIN + match[2].to_i
      end
    end
  end
end
