class SiteLifevc
  include Spider

  def self.parse(url)
    fetch(url) do
      title 'p[@class="sName"]' do |pname|
        pname.first.text.strip
      end
      image_url 'img[@class="j_previewimg"]' do |h|
        h.first['lzyimg']
      end
      # price 'p span[@class="salePrice"] em' do |em|
      #   em.first.text.strip
      # end

      price 'p[@class="sPrice"] em' do |h|
        h.first.text.strip
      end

      from {'丽芙家居'}
    end

  end

end