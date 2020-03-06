
module NDBC
  module LatestObs
    class << self
      def latest_obs_data
        response = Connection.new.get(NDBC.config[:urls][:latest_obs])
        rows = response.split("\n").drop(2)
        rows.map do |observation|
          obs_parts = cleanup_parts!(observation.split(' '))

          h = {
            id:       conv_or_nil(obs_parts[0], :to_s),
            lat:      conv_or_nil(obs_parts[1], :to_f),
            lng:      conv_or_nil(obs_parts[2], :to_f),
            year:     conv_or_nil(obs_parts[3], :to_i),
            month:    conv_or_nil(obs_parts[4], :to_i),
            day:      conv_or_nil(obs_parts[5], :to_i),
            hour:     conv_or_nil(obs_parts[6], :to_i),
            minute:   conv_or_nil(obs_parts[7], :to_i),
            wdir:     conv_or_nil(obs_parts[8], :to_f),
            wspd:     conv_or_nil(obs_parts[9], :to_f),
            gst:      conv_or_nil(obs_parts[10], :to_f),
            wvht:     conv_or_nil(obs_parts[11], :to_f),
            dpd:      conv_or_nil(obs_parts[12], :to_f),
            apd:      conv_or_nil(obs_parts[13], :to_f),
            mwd:      conv_or_nil(obs_parts[14], :to_f),
            pres:     conv_or_nil(obs_parts[15], :to_f),
            ptdy:     conv_or_nil(obs_parts[16], :to_f),
            atmp:     conv_or_nil(obs_parts[17], :to_f),
            wtmp:     conv_or_nil(obs_parts[18], :to_f),
            dewp:     conv_or_nil(obs_parts[19], :to_f),
            vis:      conv_or_nil(obs_parts[20], :to_f),
            tide:     conv_or_nil(obs_parts[21], :to_f)
          }
          # times in latest_obs.txt  file are UTC: https://www.ndbc.noaa.gov/measdes.shtml
          h[:obs_time] = Time.new(h[:year], h[:month], h[:day], h[:hour], h[:minute], 0 , "+00:00")
          h
        end
      end

      private

        def conv_or_nil(str, op)
            str.downcase == 'mm' ? nil : str.try(op)
        end

        def cleanup_parts!(obs_parts)
            obs_parts.map! do |part|
            part = part.gsub('&nbsp;', ' ')
            part = part.strip unless part.nil?
            part = (part == '' || part == '?') ? nil : part
            part
            end
        end

    end
  end
end
