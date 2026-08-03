require 'net/http'
require 'json'

namespace :moex do
  desc "Импорт облигаций с MOEX ISS API"
  task import_bonds: :environment do

uri = URI("https://iss.moex.com/iss/engines/stock/markets/bonds/securities.json?securities.columns=SECID,SHORTNAME,ISIN,MATDATE,COUPONPERCENT,FACEVALUE,FACEUNIT&iss.meta=off")
    response = Net::HTTP.get(uri)
    parsed = JSON.parse(response)

    columns = parsed["securities"]["columns"]
    rows = parsed["securities"]["data"]
    rows.each do |row|
      hash = columns.zip(row).to_h
      next if hash["ISIN"].nil?

      Bond.find_or_create_by(isin: hash["ISIN"]) do |b|
        b.name = hash["SHORTNAME"]
        b.issuer = "MOEX"
        b.coupon_rate = hash["COUPONPERCENT"]
        b.face_value = hash["FACEVALUE"]
        b.maturity_date = hash["MATDATE"]
        b.currency = hash["FACEUNIT"]
      end
    end

        puts "Импортировано облигаций: #{Bond.count}"
  end
end