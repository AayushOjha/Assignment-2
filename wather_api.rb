require 'httparty'
require 'json'

cities_list = {"Santorini" => 56558361 ,"London" => 44418, "las Vegas" => 2436704, "Mumbai" => 12586539, "Delhi" => 28743736,"Dubai" => 1940345}

puts "Plesae Enter the city name for which you want to see the min and max tempature -"
cities_list.each do |k,v|
  puts k
end
 
puts "-" * 25

selection = gets.chomp
selection_id = nil

cities_list.each do |k,v|
  if selection.downcase == k.downcase
    selection_id = v
  end  
end

if selection_id == nil 
  puts "You entred a wrong city name"
  exit
else
  response = HTTParty.get("https://www.metaweather.com/api/location/#{selection_id}/")
  res_obj = JSON.parse(response.body)
  res_singleton = res_obj['consolidated_weather'][0]
  max_temp = res_singleton['max_temp']
  min_temp = res_singleton['min_temp']
end

puts "The maximum and minmum temprature in #{selection} ranges - #{min_temp} to #{max_temp} "

