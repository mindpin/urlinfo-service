class SiteBookDoubanCom
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'div[@id="wrapper"] h1 span'
      image_url 'div[@id="mainpic"] a img', :text do |h|
        h.first['src']
      end
      author 'div[@id="info"] span a', :text do |h|
        h.first.text
      end
      price 'div[@id="info"]', :text do |h|
        h.to_s.split('定价:</span>')[1].split('<br>')[0].strip
      end
    end

  end

end