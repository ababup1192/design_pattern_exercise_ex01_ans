require 'test/unit'
require_relative '../src/ex01'

class TestSortingList < Test::Unit::TestCase
  # 仕分けリストを初期化し、テストで使い回す。
  setup do
    @store1 = Store.new
    @store2 = Store.new
    @store3 = Store.new
    @store4 = Store.new
    @list = SortingList.new(@store1, @store2, @store3, @store4)
  end
  test ':key を預けた場合、store1 が select_store により選ばれる' do
    actual = @list.select_store(:key)
    assert_true actual.equal?(@store1)
  end
  test ':laptop を預けた場合、
                            store2 が select_store により選ばれる' do
    actual = @list.select_store(:laptop)
    assert_true actual.equal?(@store2)
  end
  test ':golf_club を預けた場合、
                             store3 が select_store により選ばれる' do
    actual = @list.select_store(:golf_club)
    assert_true actual.equal?(@store3)
  end
  test '登録されていない荷物 を預けた場合、
                              store4 がselect_store により選ばれる' do
    actual = @list.select_store(:ball)
    assert_true actual.equal?(@store4)
  end
end

class TestStore < Test::Unit::TestCase
  test '預けたものを、そのまま取り出す' do
    store = Store.new
    baggages = [:key]
    phone_number = 'xxx-xxxx-xxxx'
    store.check(phone_number, baggages)

    expected = baggages
    actual = store.take(phone_number)

    assert_equal expected, actual
  end
  test '荷物は複数回、預けることが出来る' do
    store = Store.new
    baggages1 = [:key]
    baggages2 = [:ball, :golf_club]
    phone_number = 'xxx-xxxx-xxxx'
    store.check(phone_number, baggages1)
    store.check(phone_number, baggages2)

    expected = baggages1 + baggages2
    actual = store.take(phone_number)

    assert_equal expected, actual
  end
  test '預けていない電話番号では、取り出せない' do
    store = Store.new
    baggages = [:key]
    phone_number = 'xxx-xxxx-xxxx'
    store.check(phone_number, baggages)

    expected = []
    actual = store.take('ooo-oooo-oooo')

    assert_equal expected, actual
  end
  test '倉庫の内容が預けたもので構成される' do
    store = Store.new
    baggages1 = [:key, :bag]
    baggages2 = [:golf_club, :ball]
    baggages3 = [:dog, :cat]
    phone_number1 = 'xxx-xxxx-xxxx'
    phone_number2 = 'ooo-oooo-oooo'
    phone_number3 = 'oxo-oxox-oxox'

    store.check(phone_number1, baggages1)
    store.check(phone_number2, baggages2)
    store.check(phone_number3, baggages3)

    expected = {
      phone_number1 => baggages1,
      phone_number2 => baggages2,
      phone_number3 => baggages3
    }
    actual = store.contents

    assert_equal expected, actual
  end
end

class TestStore < Test::Unit::TestCase
  sub_test_case 'Reception' do
    test '預けたものが返る' do
      reception = Reception.new
      baggages = [:key, :bag, :ball, :golf_club]
      phone_number = 'xxx-xxxx-xxxx'
      reception.check(phone_number, baggages)

      expected = baggages.sort
      actual = reception.take(phone_number).sort

      assert_equal expected, actual
    end
  end
end
