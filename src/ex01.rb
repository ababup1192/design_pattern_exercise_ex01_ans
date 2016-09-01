# 仕分けリスト
class SortingList
  # 仕分け先の倉庫
  def initialize(store1, store2, store3, store4)
    @store1 = store1
    @store2 = store2
    @store3 = store3
    @store4 = store4

    # リスト [倉庫, [荷物の種類]] の配列。
    @list = [
      [@store1, [:key, :small_articles]], 
      [@store2, [:bag, :laptop]],
      [@store3, [:golf_club, :suitcase]]
    ].freeze
  end

  # 荷物を預けるのに、適当な倉庫を選ぶメソッド
  def select_store(baggage)
    # リストから、倉庫毎の荷物の種類を条件として篩に掛ける。
    # 条件に合致する配列があった場合、先頭の配列(重複は無いため)を返す。
    selected = @list.select { 
      |store_baggages| store_baggages[1].include?(baggage)
    }[0]
    # 先頭の配列がなかった場合は、@store4、あった場合は、合致したstoreを返す。
    selected.nil? ? @store4 : selected[0]
  end
end

# 倉庫
class Store
  # 預けている荷物 {電話番号: [荷物]} の形をしたHash
  attr_reader :contents
  def initialize
    @contents = Hash.new
  end

  # 電話番号をkey [荷物] をValueとして荷物を預ける
  def check(phone_number, baggages)
    # もし、既に荷物が預けられている場合は、荷物をまとめる
    if @contents.key?(phone_number) then
      # 既に預けられている荷物と新しい荷物を併せる。
      @contents[phone_number] = @contents[phone_number] + baggages
    else
      @contents[phone_number] = baggages
    end
  end

  # 電話番号から[荷物]を取り出す。存在しない場合は、空の配列を返す。
  # 取り出した荷物は、@contentsから削除する。
  def take(phone_number)
    # 一致する電話番号があれば荷物をハッシュから削除しつつ返す。
    # 一致しなければ、ブロック構文が返す値(空の配列)を返す。
    @contents.delete(phone_number) { |pnum| [] }
  end
end

