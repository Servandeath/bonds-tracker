json.extract! bond, :id, :isin, :name, :issuer, :coupon_rate, :face_value, :maturity_date, :currency, :created_at, :updated_at
json.url bond_url(bond, format: :json)
