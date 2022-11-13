class GildedRose

  def initialize(items)
    @items = items
  end

  def increase_quality_of(item)
    item.quality += 1
  end

  def decrease_quality_of(item)
    item.quality -= 1
  end

  def increase_age_of(item)
    item.sell_in -= 1
  end

  def past_sell_by_date?(item)
    item.sell_in < 0
  end

  def at_max_quality?(item)
    item.quality == 50
  end

  def at_min_quality?(item)
    item.quality == 0
  end

  def update_aged_brie(item)
    increase_age_of(item)

    return if at_max_quality?(item)
    increase_quality_of(item)
    increase_quality_of(item) if past_sell_by_date?(item) && !at_max_quality?(item)
  end

  def update_backstage_passes(item)
    increase_age_of(item)
    return item.quality = 0 if past_sell_by_date?(item)

    return if at_max_quality?(item)
    increase_quality_of(item)
    increase_quality_of(item) if item.sell_in < 10
    increase_quality_of(item) if item.sell_in < 5
  end

  def update_conjured_item(item)
    increase_age_of(item)
    return if at_min_quality?(item)
    2.times { decrease_quality_of(item) if !at_min_quality?(item)}
    2.times { decrease_quality_of(item) if past_sell_by_date?(item) && !at_min_quality?(item) }
  end

  def update_common(item)
    increase_age_of(item)
    return if at_min_quality?(item)
    decrease_quality_of(item)
    decrease_quality_of(item) if past_sell_by_date?(item) && !at_min_quality?(item)
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      case item.name
      when "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_passes(item)
      when "Aged Brie"
        update_aged_brie(item)
      when "Conjured Mana Cake"
        update_conjured_item(item)
      else
        update_common(item)
      end
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
