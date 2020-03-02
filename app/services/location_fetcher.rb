class LocationFetcher

  def connection
    Faraday.new("https://maps.googleapis.com")
  end

  def get_location(params)
    conn = connection
    response = conn.get("maps/api/geocode/json") do |req|
      req.params['address'] = "#{params}"
      req.params['key'] = ENV['GOOGLE_API']
    end
    location_parse(response)
  end

  def location_parse(response)
    parse = JSON.parse(response.body, symbolize_names: true)
    Location.save_location(parse)
  end

  def get_distance(start, destination)
    conn = connection
    #could not get this to recognize that I was passing an origin params to work,
    #wrote out url for the sake of time

    # response = conn.get("maps/api/directions/json") do |req|
    #   req.params['origin'] = "#{start.latitude}","#{start.longitude}"
    #   req.params['destination'] = "#{destination.latitude}","#{destination.longitude}"
    #   req.params['key'] = ENV['GOOGLE_API']
    # end

    response = conn.get("maps/api/directions/json?origin=#{start.latitude},#{start.longitude}
                        &destination=#{destination.latitude},#{destination.longitude}&key=#{ENV['GOOGLE_API']}")
    distance_parse(response)
  end

  def distance_parse(response)
    parse = JSON.parse(response.body, symbolize_names: true)
    Trip.new(parse)
  end
end
