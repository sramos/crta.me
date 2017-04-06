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
    # Use overrided to_param to find stored url
    redirect_to root_url unless @url = StoredUrl.find_by_slug(params[:id])
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
    uri = stored_url_params[:destination] if params[:stored_url]
    uri = "http://#{uri}" unless uri.nil? || uri[/^https?:\/\//]
    @url = StoredUrl.find_or_initialize_by(destination: uri)
    respond_to do |format|
      # If id exists dont save it
      if @url.id || @url.save
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

  def stored_url_params
    params.require(:stored_url).permit(:destination)
  end

  def hit_params
    { ip_address: request.remote_ip, referer: request.referrer }
  end
end
