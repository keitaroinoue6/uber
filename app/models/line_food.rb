class LineFood < ApplicationRecord
  belongs_to :food
  belongs_to :restaurant
  belongs_to :order, optional: true #関連付けが任意になります。存在しなくてもいいという意味です

  validates :count, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) } #railsのscopeはモデルそのものや関連するオブジェクトに対するクエリを指定することができますそしてその返り値は必ずActiveRecord_Relation
  scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id)} #restaurant_idがとくいの店舗IDではないものを一覧にして返してくれます。

  def total_amount #インスタンスメソッド
    food.price * count #foodの金額と数量を掛け合わせた line_foodの合計価格を求めるものです。
    #モデルに記述することで、さまざまな箇所から呼び出すことができます。
  end
  
end