class SiteVancl
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'div[@id="productTitle"] h2'
      image_url 'div[@id="vertical"] img' do |h|
        h.first['src']
      end
      price 'span[@class="tehuiMoney"] span strong'

      from {'凡客'}
    end

  end

end