class StoredUrlsController < ApplicationController
  def redirect
    url = StoredUrl.find_by_slug params[:slug]
    if url
      destination = url.destination
      #destination.hit.create()
      #destination.increment!(:hits_count)
    else
      destination = root_path
    end
    redirect_to destination
  end
end
