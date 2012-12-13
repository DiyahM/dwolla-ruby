class OrderItem < Hash
  attr_accessor :name,
                :description,
                :price,
                :quantity

  def intialize(attrs)
    attrs.each do |key, value|
      send("#{key}=", value)
    end
  end
end
