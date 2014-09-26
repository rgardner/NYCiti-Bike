require "date"

require "citibike"

RSpec.describe CitiBike::BikeTrip, "#initialize" do
  context "with normal data" do
    it "returns valid bike trip" do
      start_time = "06/16/2016 8:48:49 PM"
      start_station = "W 63 St & Broadway"
      end_time = "06/16/2016 9:15:49 PM"
      end_station = "W 82 St & Central Park West"
      duration = "16 min 26 s"

      trip = CitiBike::BikeTrip.new(start_time, start_station, end_time, end_station, duration)

      expect(trip.start_time).to eq DateTime.new(2016, 6, 16, 20, 48, 49)
      expect(trip.start_station).to eq start_station
      expect(trip.end_time).to eq DateTime.new(2016, 6, 16, 21, 15, 49)
      expect(trip.end_station).to eq end_station
      expect(trip.duration).to eq 986
    end
  end

  context "with partial data" do
    it "returns valid bike trip" do
      start_time = "06/16/2016 8:48:49 PM"
      start_station = "W 63 St & Broadway"
      end_time = "-"
      end_station = ""
      duration = "-"

      trip = CitiBike::BikeTrip.new(start_time, start_station, end_time, end_station, duration)

      expect(trip.start_time).to eq DateTime.new(2016, 6, 16, 20, 48, 49)
      expect(trip.start_station).to eq start_station
      expect(trip.end_time).to be_nil
      expect(trip.end_station).to be_empty
      expect(trip.duration).to be_nil
    end
  end
end

RSpec.describe CitiBike::BikeTrip, "#to_csv" do
  context "with normal data" do
    it "returns valid csv data" do
      start_time = "06/16/2016 8:48:49 PM"
      start_station = "W 63 St & Broadway"
      end_time = "06/16/2016 9:15:49 PM"
      end_station = "W 82 St & Central Park West"
      duration = "16 min 26 s"
      trip = CitiBike::BikeTrip.new(start_time, start_station, end_time, end_station, duration)

      csv = trip.to_csv

      expect(csv).to eq "W 63 St & Broadway,2016-06-16T20:48:49+00:00," \
                        "W 82 St & Central Park West,2016-06-16T21:15:49+00:00,986\n"
    end
  end

  context "with partial data" do
    it "returns csv data with null values" do
      start_time = "06/16/2016 8:48:49 PM"
      start_station = "W 63 St & Broadway"
      end_time = "-"
      end_station = ""
      duration = "-"
      trip = CitiBike::BikeTrip.new(start_time, start_station, end_time, end_station, duration)

      csv = trip.to_csv

      expect(csv).to eq "W 63 St & Broadway,2016-06-16T20:48:49+00:00,,,\n"
    end
  end
end
