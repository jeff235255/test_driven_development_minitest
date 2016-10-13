require "minitest/autorun"
require_relative "money"
require_relative "bank"

class MoneyTest < Minitest::Test
  def test_multiplication
    five = Money.dollar(5).amount

    assert_equal(Money.dollar(10).amount, five * 2)
    assert_equal(Money.dollar(15).amount, five * 3)
  end

  def test_equality
    assert(Money.dollar(5).amount == Money.dollar(5).amount)
    refute(Money.dollar(5).amount == Money.dollar(6).amount)
    refute(Money.dollar(5) == Money.franc(5))
  end

  def test_currency
    assert_equal(:USD, Money.dollar(1).currency)
    assert_equal(:CHF, Money.franc(1).currency)
    assert_equal(:VND, Money.vnd(5).currency)
  end

  def test_exchange_dollar_to_vnd
    bank = Bank.new

    assert_in_delta Bank::VND_RATE, bank.exchange_dollar_to_vnd(1), 0.01
    assert_in_delta Bank::VND_RATE * 5, bank.exchange_dollar_to_vnd(5), 0.01
  end

  def test_exchange_money_to_dollar
    bank = Bank.new

    assert_in_delta((17.000 / Bank::VND_RATE).round(2), bank.exchange_money_to_dollar(17.000, :VND), 0.1)
    assert_in_delta((10 / Bank::FRN_RATE).round(2), bank.exchange_money_to_dollar(10, :CHF), 0.1)
  end

  def test_raises_errors_when_invalid_currency
    assert_raises "Currency has invalid format." do
      bank = Bank.new
      bank.exchange_money_to_dollar(10, :AUD)
    end
  end
end