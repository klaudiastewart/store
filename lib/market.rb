class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def total_inventory
    inventory = {}
    @vendors.each do |vend|
      vend.inventory.each do |item, quantity|
        if inventory[item].nil?
          inventory[item] = {quantity: quantity, vendors: [vend]}
        else
          inventory[item][:quantity] += quantity
          inventory[item][:vendors] << vend
        end
      end
    end
    inventory
  end

  def overstocked_items
    overstock = []
    total_inventory.each do |item, info|
      overstock << item if info[:quantity] > 50 && info[:vendors].count > 1
    end
    overstock
  end
end
