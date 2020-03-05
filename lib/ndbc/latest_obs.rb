module NDBC
  module LatestObs
    class << self
      def latest_obs_data
        response = Connection.new.get(NDBC.config[:urls][:latest_obs])
        rows = response.split("\n").drop(2)
        rows.map do |observation|
          obs_parts = cleanup_parts!(observation.split(' '))

          {
            id:       obs_parts[0],
            lat:      obs_parts[1].try(:to_f),
            lng:      obs_parts[2].try(:to_f),
            year:     obs_parts[3].try(:to_i),
            month:    obs_parts[4].try(:to_i),
            day:      obs_parts[5].try(:to_i),
            hour:     obs_parts[6].try(:to_i),
            minute:   obs_parts[7].try(:to_i),
            wdir:     obs_parts[8].try(:to_f),
            wspd:     obs_parts[9].try(:to_f),
            gst:      obs_parts[10].try(:to_f),
            wvht:     obs_parts[11].try(:to_f),
            dpd:      obs_parts[12].try(:to_f),
            apd:      obs_parts[13].try(:to_f),
            mwd:      obs_parts[14].try(:to_f),
            pres:     obs_parts[15].try(:to_f),
            ptdy:     obs_parts[16].try(:to_f),
            atmp:     obs_parts[17].try(:to_f),
            wtmp:     obs_parts[18].try(:to_f),
            dewp:     obs_parts[19].try(:to_f),
            vis:      obs_parts[20].try(:to_f),
            tide:     obs_parts[21].try(:to_f)
          }
        end
      end

      private

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
