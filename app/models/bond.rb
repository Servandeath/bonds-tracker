class Bond < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["coupon_rate", "currency", "face_value", "isin", "issuer", "maturity_date", "name"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end