class SitePageParser

  attr_accessor :url, :hostname, :homepage, :image_url, :title, :desc, :price, :location, :author, :from

  def initialize(url)
    @url = url

    res = Net::HTTP.get_response(URI(url.split('#')[0]))
    unless res['location'] and res['location'].include? 'http://jump.taobao.com/jump'
      url = res['location'].nil?? url : res['location']
    end

    p res['location']
    p '-----'
    p url
    p '====='

    @hostname = URI.parse(URI.encode(url)).host
    @homepage = get_homepage(url)
    
    name = get_name
    # return unless name
    data = eval "Site#{name}.parse(url)"
    

    p data
    p '===='

    @image_url = data[:image_url]
    @title = data[:title]
    @desc = data[:desc]
    @price = data[:price]
    @location = data[:location]
    @author = data[:author]
    @from   = data[:from]

  end


  def get_homepage(url)
    domain_parts = @hostname.split('.')
    temp = @hostname.gsub('.com', '').gsub('.cn', '')

    "www.#{temp.split('.').last}.#{domain_parts.last}"
  end


  def get_name
    return get_name_from_itunes if @hostname == 'itunes.apple.com'
    return get_name_from_vipship if @hostname == 'archive-shop.vip.com'


    hostname = @hostname.gsub('.', '_')
    if File.file?("#{Rails.root.to_s}/lib/site_data/site_#{hostname}.rb")
       return hostname.split('_').map { |item| item.capitalize }.join
    end

    name = @hostname.gsub('.com', '').gsub('.cn', '').split('.').last
    return  name.capitalize if File.file?("#{Rails.root.to_s}/lib/site_data/site_#{name}.rb")
    nil
  end


  def get_name_from_itunes
    hostname = @hostname.split('.').map { |item| item.capitalize }.join

    return hostname + "Book" if @url.include? '/book/'
    return hostname + "Podcast" if @url.include? '/podcast/'

    hostname + "Appstore"
  end


  def get_name_from_vipship
    'VipShop'
  end

end