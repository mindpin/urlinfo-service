class SiteYhd
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'h1[@id="productMainName"]'
      image_url 'img[@id="J_prodImg"]', :text do |h|
        h.first['src']
      end
      price 'span[@class="current_price"]' do |h|
        pid = URI.parse(url).path.gsub("/item/","")
        mechanize = Mechanize.new
        mechanize.retry_change_requests = true
        price_url = "http://gps.yhd.com/restful/detail?mcsite=1&provinceId=4&pmId=#{pid}&callback=jsonp"
        page = mechanize.get(price_url)
        JSON.parse(page.body.gsub(/jsonp\((.*)\)/,"\\1"))["currentPrice"]
      end
    end

  end

end