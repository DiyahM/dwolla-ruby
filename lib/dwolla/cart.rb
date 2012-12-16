class Cart
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
    @order_items = []
    attrs.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def to_hash
    hash = {}
    instance_variables.each do |var|
      key = var.to_s.delete("@").split('_').collect(&:capitalize).join
      hash[key] = instance_variable_get(var)
    end
    hash
  end

  def add_order_item(order_item)
    @order_items << order_item.to_hash
  end

end
