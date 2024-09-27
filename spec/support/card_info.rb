require 'yaml'
require 'cucumber'


@@giftcardinfo_yml = YAML::load_file(File.join(__dir__, 'data/gift_card_details.yml'))


class GiftCardsinfo

  # Return a hash representing gift card data
  def self.get_giftcardsinfo country
    return @@giftcardinfo_yml['Cardinfo'][country]
  end

end