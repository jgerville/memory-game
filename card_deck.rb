class CardDeck

  attr_reader :card_values # , :deck

  def initialize(card_values)
    @card_values = card_values
    # @deck = []
    # @deck_size.times { @deck << @card_values.sample }
  end

end
