require "ndbc/version"
require "ndbc/connection"
require "ndbc/station_table"
require "ndbc/station"
require "ndbc/exceptions"
require "ndbc/latest_obs"

module NDBC

  @config = {
    urls: {
      station_table: "https://www.ndbc.noaa.gov/data/stations/station_table.txt",
      observations: "https://www.ndbc.noaa.gov/data/realtime2/",
      predictions: "http://polar.ncep.noaa.gov/waves/WEB/multi_1.latest_run/plots/",
      latest_obs: "https://www.ndbc.noaa.gov/data/latest_obs/latest_obs.txt"
    }
  }

  def self.config
    @config
  end
end
