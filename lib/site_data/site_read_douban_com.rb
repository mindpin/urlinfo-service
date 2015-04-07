class SiteReadDoubanCom
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'h1[@class="article-title"]'
      image_url 'div[@class="cover shadow-cover"] img', :text do |h|
        h.first['src']
      end
      author 'a[@class="author-item"]'
      price 'span[@class="price-tag "]'
    end

  end

end