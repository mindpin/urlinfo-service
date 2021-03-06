class SiteTaobao
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'h3[@class="tb-main-title"]'
      image_url  'script' do |h|
        h.to_s.split('auctionImages:[')[1].split(',')[0].gsub('"', '').gsub(' ]', '').strip
      end

      # price do |h|
      #   get_price
      # end


      price 'script' do |h|
        str = h.to_s
        items = str.scan('price:')
        if items.length > 0
          str.split('price:')[1].split(',')[0]
        else
          get_price
        end
      end

      from {'淘宝'}
    end

  end

  def self.get_price
    pid = URI.parse(URI.encode(url)).query.split("&").select do |str|
      str.match(/id=.*/)
    end[0].gsub("id=","")
    mechanize = Mechanize.new
    mechanize.keep_alive = false
    mechanize.user_agent_alias = 'Windows Chrome'
    price_url = "http://mdskip.taobao.com/core/initItemDetail.htm?itemId=#{pid}"
    page = mechanize.get(price_url, parameters = [], referer = url )
    parse_price_by_reg(page.body)
  end

  def self.parse_price_by_reg(str)
    str.scan(/\"price\"\:\"([^,]*)\",/).flatten.map{|p|p.to_f}.min
  end

end