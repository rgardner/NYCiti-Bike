require "htmlentities"
require "mechanize"

require_relative "exceptions"
require_relative "models/bike_trip"

module CitiBike
  # Download bike trip data from the Citi Bike website.
  class Scraper
    LOGIN_URL = "https://member.citibikenyc.com/profile/login"

    attr_reader :username

    def initialize(username, password)
      @agent = Mechanize.new
      @username = username
      @password = password
      login(username, password)
    end

    ##
    # Returns the bike trips in the last +number_of_months+.
    #
    # Params
    # +number_of_months+:: can be nil

    def trips(num_pages)
      @agent.click("Trips")
      if @agent.page.code.to_i != 200
        raise CitiBikeError, "Failed to load trips page"
      end

      trips = []
      while true
        rows = Nokogiri::HTML(@agent.page.body).xpath("//table/tbody/tr")
        trips.push(*rows_to_trips(rows))

        num_pages -= 1 unless num_pages.nil?
        break unless num_pages.nil? || num_pages > 0

        next_link = @agent.page.link_with(:text => "Older")
        break if next_link.dom_class.include?("disabled")
        break unless @agent.click(next_link)
      end
      trips
    end

    private

    def login(username = "", password = "")
      username = @username if username.empty?
      password = @password if password.empty?
      @agent.get(LOGIN_URL)
      @agent.page.forms[0]["_username"] = username
      @agent.page.forms[0]["_password"] = password
      @agent.page.forms[0].submit
      if @agent.page.code.to_i != 200
        raise CitiBikeError, "Invalid username or password."
      end
    end

    def rows_to_trips(rows)
      trips = []
      rows.each do |row|
        # e.g. 06/16/2016 8:48:49 PM
        start_time = row.at_xpath("td[1]/div[1]/text()").to_s.strip
        end_time = row.at_xpath("td[2]/div[1]/text()").to_s.strip
        # e.g. W 63 St & Broadway
        coder = HTMLEntities.new
        start_station = coder.decode(row.at_xpath("td[1]/div[2]/text()").to_s.strip)
        end_station = coder.decode(row.at_xpath("td[2]/div[2]/text()").to_s.strip)
        # 16 min 26 s
        duration = row.at_xpath("td[3]/text()").to_s.strip
        trips.push(BikeTrip.new(start_time, start_station, end_time, end_station, duration))
      end
      trips
    end
  end
end
