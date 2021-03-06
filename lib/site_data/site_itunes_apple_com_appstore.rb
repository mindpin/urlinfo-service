class SiteItunesAppleComAppstore
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'h1[@itemprop="name"]'
      image_url 'div[@id="left-stack"] meta' do |h|
        h.first['content']
      end
      price 'div[@class="price"]'

      author 'span[@itemprop="name"]'

      from {'App Store（中国）'}
    end

  end

end