class SiteItunesAppleComBook
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'div[@id="title"] h1'
      image_url 'div[@id="left-stack"] meta' do |h|
        h.first['content']
      end
      price 'li div[@class="price"]'

      author 'div[@id="title"] h2' do |h|
        h.text.strip.gsub('By', '').strip
      end

      from {'iTunes Store - 图书（中国）'}
    end

  end

end