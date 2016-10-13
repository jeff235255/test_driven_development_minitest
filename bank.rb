class Bank
  VND_RATE = 22.200 
  FRN_RATE = 0.91

  def exchange_dollar_to_vnd usd
    (VND_RATE * usd).round(3)
  end

  def exchange_money_to_dollar money, currency
    raise "Currency has invalid format." if is_currency_valid? currency

    if currency == :CHF 
      (money / FRN_RATE).round(2)
    elsif currency == :VND
      (money / VND_RATE).round(2) 
    end
  end

  private
  def is_currency_valid? currency
    currency != :VND && currency != :CHF
  end
end