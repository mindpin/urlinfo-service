class SiteWandoujia
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'span[@class="title"]'
      image_url 'div[@class="app-icon"] img', :text do |h|
        h.first['src']
      end

      author 'dd[@itemprop="author"] a span'

    end

  end

end