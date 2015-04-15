class SiteItruelife
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'div[@class="detail-main"] h1'
      image_url 'a[@class="cloud-zoom"]' do |h|
        h.first["href"]
      end
      price 'ins[@class="ff_arial"]'

      from {'凡夫'}
    end

  end

end