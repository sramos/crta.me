class StoredUrlsController < ApplicationController

  # GET /:slug
  # Redirect to long url from slug
  def redirect
    url = StoredUrl.find_by_slug params[:slug]
    if url
      url.hits.create(hit_params)
      destination = url.destination
    else
      destination = root_url
    end
    redirect_to destination
  end

  def show
    @url = StoredUrl.find_by_id(params[:id])
  end

  # GET /
  # New shorter url form
  def new
    @url = StoredUrl.new
  end

  # POST /stored_urls
  # POST /stored_urls.xml
  # Save new stored_url
  def create
    @url = StoredUrl.new(url_params)
    respond_to do |format|
      if @url.save
        flash[:notice] = 'Link was successfully created.'
	format.html { redirect_to stored_url_url(@url) }
	format.xml  { render :xml => @url, :status => :created, :location => @url.destination }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @url.errors, :status => :unprocessable_entity }
      end
    end
  end

 private

  def url_params
    params.require(:url).permit(:destination)
  end

  def hit_params
    { ip_address: request.remote_id, referer: request.referrer }
  end
end
