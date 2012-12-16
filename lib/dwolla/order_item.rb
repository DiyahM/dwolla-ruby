class OrderItem
  attr_accessor :name,
                :description,
                :price,
                :quantity

  def initialize(attrs)
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
end
