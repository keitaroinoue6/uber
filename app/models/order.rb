class Order < ActiveRecord
  has_many :ine_foods
  has_one :restaurant, through: :line_food
  
  validates :total_price, numericality: { greater_than: 0 }

  def save_with_update_line_foods!(line_foods)
    ActiveRecord::Base.transaction do #この処理をトランザクションの中で行うようにすることで、この二つの処理のいずれかが失敗した場合に全ての処理を無かったことにする
      line_foods.each do |line_food|
        line_food.update_attributes!(active: false, order: self)
      end
      self.save!
    end
  end
end