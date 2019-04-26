require 'yaml'
path_to_file = "./config/timing#{ENV['VARIANT']}.yml"
timing_data = YAML.load_file(path_to_file)['timing']
require 'pry'

class MetroInfopoint

  def initialize(timing_file = nil)
    @timing_file = timing_file
  end

  def calculate(from_station:, to_station:)
      { price: calculate_price(from_station: from_station, to_station: to_station),
      time: calculate_time(from_station: from_station, to_station: to_station) }
  end


  def calculate_price(from_station:, to_station:)
    metro_data_range = take_data_range(from_station, to_station)
    price = metro_data_range.map { |arr_elem| arr_elem['price'] }.inject(0) {|x,n| x+n }
  end

  def calculate_time(from_station:, to_station:)
    metro_data_range = take_data_range(from_station, to_station)
    time = metro_data_range.map { |arr_elem| arr_elem['time'] }.inject(0) {|x,n| x+n }
  end

  private

  def take_data_range(from_station, to_station)
    @timing_file[@timing_file.index(@timing_file.find{ |e| (e['start'] == from_station.to_sym) })..@timing_file.index(@timing_file.find{ |e| (e['end'] == to_station.to_sym) })]
  end

end

m = MetroInfopoint.new(timing_data)
puts m.calculate(from_station:'shevchenkivska',to_station:'banderivska')
