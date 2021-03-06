class ApiController < ApplicationController
  before_filter :set_access_control_headers

  def set_access_control_headers
    if !request.headers["Origin"].blank?
      response.headers['Access-Control-Allow-Origin']   = request.headers["Origin"]
    end
  end

  def fetch_infocard
    site_page = SitePage.parse_url(URI.encode(params[:url]))

    p site_page
    p '---'

    if site_page.title
      render :status => 200, :json => site_page.api_hash
    else
      render :status => 500, :json => {:status => 'error'}
    end
    

    rescue Exception => e
      render :status => 500, :json => {:status => 'error'}

    # render :nothing => true
  end
end