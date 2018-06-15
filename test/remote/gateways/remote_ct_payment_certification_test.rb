require 'test_helper'

class RemoteCtPaymentCertificationTest < Test::Unit::TestCase
  def setup
    @gateway = CtPaymentGateway.new(fixtures(:ct_payment))

    @amount = 100
    @declined_card = credit_card('4502244713161718')
    @options = {
      billing_address: address,
      description: 'Store Purchase',
      merchant_terminal_number: '13366',
      order_id: generate_unique_id[0,11]
    }
  end

  def test1
    @credit_card = credit_card('4501161107217214', month: 07, year:2025)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(1, response)
  end

  def test2
    @credit_card = credit_card('5194419000000007', month: 07, year:2025)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(2, response)
  end

  def test3
    @credit_card = credit_card('341400000000000', month: 07, year:2025)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(3, response)
  end

  def test6
    @credit_card = credit_card('341400000000000', month: 07, year:2025)
    response = @gateway.refund(@amount, @credit_card, @options)
    print_result(6, response)
  end

  def test4
    @credit_card = credit_card('4501161107217214', month: 07, year:2025)
    response = @gateway.refund(@amount, @credit_card, @options)
    print_result(4, response)
  end

  def test5
    @credit_card = credit_card('5194419000000007', month: 07, year:2025)
    response = @gateway.refund(@amount, @credit_card, @options)
    print_result(5, response)
  end

  def test7
    @credit_card = credit_card('4501161107217214', month: 07, year:2025)
    response = @gateway.authorization(@amount, @credit_card, @options)
    print_result(7, response)

    capture_response = @gateway.capture(@amount, response.authorization, @options)
    print_result(10, capture_response)
  end

  def test8
    @credit_card = credit_card('5194419000000007', month: 07, year:2025)
    response = @gateway.authorization(@amount, @credit_card, @options)
    print_result(8, response)

    capture_response = @gateway.capture(@amount, response.authorization, @options)
    print_result(11, capture_response)
  end

  def test9
    @credit_card = credit_card('341400000000000', month: 07, year:2025)
    response = @gateway.authorization(@amount, @credit_card, @options)
    print_result(9, response)

    capture_response = @gateway.capture(@amount, response.authorization, @options)
    print_result(12, capture_response)
  end

  def test13
    @credit_card = credit_card('4501161107217214', month: 07, year:2025)
    response = @gateway.purchase(000, @credit_card, @options)
    print_result(13, response)
  end

  def test14
    @credit_card = credit_card('4501161107217214', month: 07, year:2025)
    response = @gateway.purchase(-100, @credit_card, @options)
    print_result(14, response)
  end

  def test15
    @credit_card = credit_card('4501161107217214', month: 07, year:2025)
    response = @gateway.purchase('-1A0', @credit_card, @options)
    print_result(15, response)
  end

  def test16
    @credit_card = credit_card('5194419000000007', month: 07, year:2025)
    @credit_card.brand = 'visa'
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(16, response)
  end

  def test17
    @credit_card = credit_card('4501161107217214', month: 07, year:2025)
    @credit_card.brand = 'master'
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(17, response)
  end

  def test18
    @credit_card = credit_card('', month: 07, year:2025)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(18, response)
  end

  def test19
    @credit_card = credit_card('1234123412341234', month: 07, year:2025)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(19, response)
  end

  def test20
    @credit_card = credit_card('4501161107217214', month: 07, year:2)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(20, response)
  end

  def test21
    @credit_card = credit_card('4501161107217214', month: 17, year:2017)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(21, response)
  end

  def test22
    @credit_card = credit_card('4501161107217214', month: 01, year:2016)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(22, response)
  end

  def test23
    @credit_card = credit_card('4501161107217214', month: '', year:'')
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(23, response)
  end

  def test24
    @credit_card = credit_card('4502244713161718', month: 07, year:2025)
    response = @gateway.purchase(@amount, @credit_card, @options)
    print_result(24, response)
  end

  def print_result(test_number, response)
    puts "Test #{test_number} | transaction number: #{response['transactionNumber']}, invoice number #{response['invoiceNumber']}, timestamp: #{response['timeStamp']}, result: #{response['returnCode']}"
  end

end
