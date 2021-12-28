require "csv"
require 'faker'

# file generator

array = []

for i in 0..4999 do
  email = Faker::Internet.email
  state_decider = rand(1..5)
  state = ''
  case state_decider
  when 1
    state = "delivered"
  when 2
    state = "bounced"
  when 3
    state = "sent"
  when 4
    state = "opened"
  when 5
    state = "failed"
  else
    exit
  end
    samll_array = [email,state]
    array.append(samll_array)
end

headers = ['email address','status']

CSV.open("mailist.csv", "w") do |csv|
  csv << headers
  array.each do |record|
    csv << record
  end
end

# csv file is created
# logic part starts here

arr_delivered = []
arr_bounced = []
arr_sent = []
arr_opened = []
arr_failed = []

imported_csv = CSV.parse(File.read("mailist.csv",headers:true))

imported_csv.each do |record|
  if record[1] == "status"
    next
  end
  case record[1]
  when "delivered"
    arr_delivered.append(record)
  when "bounced"
    arr_bounced.append(record)
  when "sent"
    arr_sent.append(record)
  when "opened"
    arr_opened.append(record)
  when "failed"
    arr_failed.append(record)
  else
    exit
  end
end

CSV.open("delivered.csv", "w") do |csv|
  csv << headers
  arr_delivered.each do |record|
    csv << record
  end
end

CSV.open("bounced.csv", "w") do |csv|
  csv << headers
  arr_bounced.each do |record|
    csv << record
  end
end

CSV.open("sent.csv", "w") do |csv|
  csv << headers
  arr_sent.each do |record|
    csv << record
  end
end

CSV.open("opened.csv", "w") do |csv|
  csv << headers
  arr_opened.each do |record|
    csv << record
  end
end

CSV.open("failed.csv", "w") do |csv|
  csv << headers
  arr_failed.each do |record|
    csv << record
  end
end