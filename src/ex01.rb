# 仕分け所
class SortingList
  def initialize(store1, store2, store3, store4)
    @store1 = store1
    @store2 = store2
    @store3 = store3
    @store4 = store4

    @list = [
      [@store1, [:key, :small_articles]], 
      [@store2, [:bag, :laptop]],
      [@store3, [:golf_club, :suitcase]]
    ].freeze
  end

  def select_store(baggage)
    selected = @list.select { 
      |store_baggages| store_baggages[1].include?(baggage)
    }[0]
    selected.nil? ? @store4 : selected[0]
  end
end

# 倉庫
class Store
  attr_reader :contents
  def initialize
    @contents = Hash.new
  end

  def check(phone_number, baggages)
    @contents[phone_number] = baggages
  end

  def take(phone_number)
     @contents.delete(phone_number) { |pnum| [] }
  end
end

# 受付係
class Reception
  def initialize
    @store1 = Store.new
    @store2 = Store.new
    @store3 = Store.new
    @store4 = Store.new
    @stores = [@store1, @store2, @store3, @store4].freeze
    @sorting_list = SortingList.new(@store1, @store2, @store3, @store4)
  end

  def check(phone_number, baggages)
    baggages.each{ |baggage|
      store = @sorting_list.select_store(baggage)
      store.check(phone_number, baggage)
    }
  end

  def take(phone_number)
    @stores.map{ |store| store.take(phone_number) }.flatten
  end
end
