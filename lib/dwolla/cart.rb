class Cart < Hash
  attr_accessor :callback,
                :redirect,
                :allow_funding_sources,
                :order_id,
                :test,
                :destination_id,
                :discount,
                :shipping,
                :tax,
                :total,
                :facilitator_amount,
                :notes,
                :order_items
  
  def initialize(attrs)
    attrs.each do |key, value|
      send("#{key}=", value)
    end
  end

end
