require_relative '../lib/scrap_logic'

describe Scraper do
  test_object = Scraper.new('sekiro')
  false_object = Scraper.new('')
  describe 'parsing' do 
    it 'returns a parsed HTML dom that ruby can work with.' do 
      expect(test_object.parsing('https://www.microsoft.com/en-us/search/shop/games?q=sekiro')).to be_a Object
    end

    it 'returns an error if the URL have an character that is not UTF-8' do
      expect {test_object.parsing("https://www.microsoft.com/en-us/search/shop/games?q=jos\u00E9")}.to raise_error(URI::Error)
    end
  end

  describe '#scrape' do
    it 'returns an array of hashes containing the name, price and link of a game in microsoft store.' do
      expect(test_object.scrape).to eql(
        ["\e[36m\nName: \e[0m\e[32mSekiro™: Shadows Die Twice - " \
         "GOTY Edition\e[0m\n\e[36mPrice: \e[0m\e[32m$59.99\e[0m\n\e[36mLink:" \
         " \e[0m\e[32mhttps://www.microsoft.com/en-us/p/sekiro-shadows-die-twice-goty-edition/bqd5wrrp2d6q\e[0m"]
      )
    end

    it 'returns an empty array if no results are found' do 
      expect(false_object.scrape).to eql([])
    end
  end

  describe '#search' do
    it 'asks the user for an input and returns the results of his search' do
      expect(search('sekiro')).to eql(
        ["\e[36m\nName: \e[0m\e[32mSekiro™: Shadows Die Twice - " \
         "GOTY Edition\e[0m\n\e[36mPrice: \e[0m\e[32m$59.99\e[0m\n\e[36mLink:" \
         " \e[0m\e[32mhttps://www.microsoft.com/en-us/p/sekiro-shadows-die-twice-goty-edition/bqd5wrrp2d6q\e[0m"]
      )
    end

    it 'returns "No results" if no parameter is passed or if no results are found' do
      expect(search('')).to eql('No results')
    end
  end
end
