class CreateBonds < ActiveRecord::Migration[8.1]
  def change
    create_table :bonds do |t|
      t.string :isin
      t.string :name
      t.string :issuer
      t.decimal :coupon_rate
      t.decimal :face_value
      t.date :maturity_date
      t.string :currency

      t.timestamps
    end
  end
end
