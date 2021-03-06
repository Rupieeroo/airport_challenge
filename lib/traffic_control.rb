require_relative 'plane.rb'
require_relative 'weather.rb'

class TrafficControl
  DEFAULT_CAPACITY = 20

  attr_reader :planes, :weather, :capacity

  def initialize(capacity = DEFAULT_CAPACITY, weather = Weather.new)
    @airport = []
    @capacity = capacity
    @weather = weather.weather_conditions
  end

  def landing_request(plane)
    if full?
      fail 'airport at capacity'
    elsif weather_check(weather) == 'take-off denied'
      fail 'adverse landing conditions'
    else
      @airport << plane
    end
  end

  def take_off_request
    if empty?
      fail 'airport is empty'
    elsif weather_check(weather) == 'take-off denied'
      fail 'adverse flight conditions'
    else
      @airport.pop
    end
  end

  def weather_check(weather)
    if weather == 'sunny'
      return 'take-off allowed'
    elsif weather == 'stormy'
      return 'take-off denied'
    end
  end

  def full?
    @airport.length == @capacity
  end

  def empty?
    @airport.length == 0
  end
end
