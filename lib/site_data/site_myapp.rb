class SiteMyapp
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'div[@class="det-name-int"]'
      image_url 'div[@class="det-icon"] img', :text do |h|
        h.first['src']
      end

      author 'div[@class="det-othinfo-data"]'

    end

  end

end