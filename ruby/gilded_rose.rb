class GildedRose

  def initialize(items)
    @items = items
  end

  def increase_quality_of(item)
    item.quality += 1
  end

  def increase_age_of(item)
    item.sell_in -= 1
  end

  def update_aged_brie(item)
    increase_age_of(item)

    return if item.quality == 50
    increase_quality_of(item)
    increase_quality_of(item) if item.sell_in < 0 && item.quality < 50
  end

  def update_backstage_passes(item)
    increase_age_of(item)
    return item.quality = 0 if item.sell_in < 0

    return if item.quality == 50
    increase_quality_of(item)
    increase_quality_of(item) if item.sell_in < 10
    increase_quality_of(item) if item.sell_in < 5
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      next update_backstage_passes(item) if item.name == "Backstage passes to a TAFKAL80ETC concert"
      next update_aged_brie(item) if item.name == "Aged Brie"
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
