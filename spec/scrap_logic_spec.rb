require './lib/scrap_logic'

describe Scraper do
  test_object = Scraper.new('sekiro')
  describe '#scrape' do
    it 'returns an array of hashes containing the name, price and link of a game in microsoft.' do
      expect(test_object.scrape).to eql(
        ["\e[36m\nName: \e[0m\e[32mSekiro™: Shadows Die Twice - " \
         "GOTY Edition\e[0m\n\e[36mPrice: \e[0m\e[32m$59.99\e[0m\n\e[36mLink:" \
         " \e[0m\e[32mhttps://www.microsoft.com/en-us/p/sekiro-shadows-die-twice-goty-edition/bqd5wrrp2d6q\e[0m"]
      )
    end
  end
end
