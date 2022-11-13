require File.join(File.dirname(__FILE__), '../gilded_rose')
require 'spec_helper'

RSpec.describe GildedRose do
  describe 'Aged Brie' do
    describe 'before or at sell by date' do
      describe 'quality is below 50' do
        let(:brie) { Item.new(name="Aged Brie", sell_in=2, quality=0) }
        it 'ages 1 day' do
          GildedRose.new([brie]).update_quality
          expect(brie.sell_in).to eq 1
        end
        it 'gains 1 quality' do
          GildedRose.new([brie]).update_quality
          expect(brie.quality).to eq 1
        end
      end
      describe 'quality is at 50' do
        let(:brie) { Item.new(name="Aged Brie", sell_in=2, quality=50) }
        it 'ages 1 day' do
          GildedRose.new([brie]).update_quality
          expect(brie.sell_in).to eq 1
        end
        it 'does not gain anymore quality' do
          GildedRose.new([brie]).update_quality
          expect(brie.quality).to eq 50
        end
      end
    end

    describe 'after the sell by date' do
      describe 'quality is bellow 50' do
        let(:brie) { Item.new(name="Aged Brie", sell_in= -1, quality=0) }
        it 'ages 1 day' do
          GildedRose.new([brie]).update_quality
          expect(brie.sell_in).to eq -2
        end
        it 'gains 2 quality' do
          GildedRose.new([brie]).update_quality
          expect(brie.quality).to eq 2
        end
      end
      describe 'quality is at 49' do
        let(:brie) { Item.new(name="Aged Brie", sell_in= -1, quality=49) }
        it 'ages 1 day' do
          GildedRose.new([brie]).update_quality
          expect(brie.sell_in).to eq -2
        end
        it 'does not go past 50 quality' do
          GildedRose.new([brie]).update_quality
          expect(brie.quality).to eq 50
        end
      end
      describe 'quality is at 50' do
        let(:brie) { Item.new(name="Aged Brie", sell_in= -1, quality=50) }
        it 'ages 1 day' do
          GildedRose.new([brie]).update_quality
          expect(brie.sell_in).to eq -2
        end
        it 'does not go past 50 quality' do
          GildedRose.new([brie]).update_quality
          expect(brie.quality).to eq 50
        end
      end
    end
  end

  describe 'Backstage Passes' do
    describe 'more than 10 days before concert' do
      describe 'quality is below 50' do
        let(:tickets) { Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20) }
        it 'ages 1 day' do
          GildedRose.new([tickets]).update_quality
          expect(tickets.sell_in).to eq 14
        end
        it 'gains 1 quality' do
          GildedRose.new([tickets]).update_quality
          expect(tickets.quality).to eq 21
        end
      end
      describe 'quality is at 50' do
        let(:tickets) { Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=50) }
        it 'ages 1 day' do
          GildedRose.new([tickets]).update_quality
          expect(tickets.sell_in).to eq 14
        end
        it 'does not gain quality' do
          GildedRose.new([tickets]).update_quality
          expect(tickets.quality).to eq 50
        end
      end
    end
    describe 'between 10 and 5 days before concert' do
      let(:tickets) { Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=7, quality=20) }
      it 'ages 1 day' do
        GildedRose.new([tickets]).update_quality
        expect(tickets.sell_in).to eq 6
      end
      it 'gains 2 quality' do
        GildedRose.new([tickets]).update_quality
        expect(tickets.quality).to eq 22
      end
    end
    describe '5 or less days before concert' do
      let(:tickets) { Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=4, quality=20) }
      it 'ages 1 day' do
        GildedRose.new([tickets]).update_quality
        expect(tickets.sell_in).to eq 3
      end
      it 'gains 3 quality' do
        GildedRose.new([tickets]).update_quality
        expect(tickets.quality).to eq 23
      end
    end
    describe 'After the concert' do
      let(:tickets) { Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=-1, quality=20) }
      it 'ages 1 day' do
        GildedRose.new([tickets]).update_quality
        expect(tickets.sell_in).to eq -2
      end
      it 'quality is 0' do
        GildedRose.new([tickets]).update_quality
        expect(tickets.quality).to eq 0
      end
    end
  end

  describe 'Common Item' do
    describe 'before sell by date' do
      describe 'quality is below 50' do
        let(:item) { Item.new(name="+5 Dexterity Vest", sell_in=1, quality=20) }
        it 'ages 1 day' do
          GildedRose.new([item]).update_quality
          expect(item.sell_in).to eq 0
        end
        it 'looses 1 quality' do
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 19
        end
      end
      describe 'quality is at 50' do
        let(:item) { Item.new(name="+5 Dexterity Vest", sell_in=10, quality=50) }
        it 'ages 1 day' do
          GildedRose.new([item]).update_quality
          expect(item.sell_in).to eq 9
        end
        it 'does not gain anymore quality' do
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 49
        end
      end
    end

    describe 'on or after the sell by date' do
      describe 'quality is bellow 50' do
        let(:item) { Item.new(name="+5 Dexterity Vest", sell_in= 0, quality=20) }
        it 'ages 1 day' do
          GildedRose.new([item]).update_quality
          expect(item.sell_in).to eq -1
        end
        it 'looses 2 quality' do
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 18
        end
      end
    end
  end
end
