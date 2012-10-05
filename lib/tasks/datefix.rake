namespace :datefix do

  desc "Convert old Date string to Date"
  task old_to_new: :environment do
    Place.where(type: "event").each do |event|
      event.temp_date = Date.parse(event.date)
      event.save
    end
  end


  desc "Convert new Date to old Date"
  task new_to_old: :environment do
    Place.where(type: "event").each do |event|
      event.date= event.temp_date
      event.save
    end
  end

end

