class SiteHiapk
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'div[@id="appSoftName"]'
      image_url 'div[@class="detail_content"] div[@class="left"] img', :text do |h|
        h.first['src']
      end

      author 'span[@class="d_u_line"]'

    end

  end

end