class SiteMuji
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'h1[@id="goodsNmArea"]'
      image_url 'meta[@property="og:image"]' do |h|
        h.first['content']
      end
      price 'script' do |h|
        json = h.first.text.match(/var JSON_DATA=(.*);/)[1]
        JSON.parse(json)["GoodsInfo"]["goods"]["cFirstPrice"]
      end

      from {'无印良品（中国）'}
    end

  end

end