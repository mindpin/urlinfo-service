class SiteItunesAppleComAppstore
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'h1[@itemprop="name"]'
      image_url 'div[@class="artwork"] img', :text do |h|
        h.first['src']
      end
      price 'div[@class="price"]'

      author 'span[@itemprop="name"]'
    end

  end

end