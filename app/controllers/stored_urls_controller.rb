class StoredUrlsController < ApplicationController
  def redirect
    url = StoredUrl.find_by_slug params[:slug]
    if url
      url.hits.create(hit_params)
      destination = url.destination
    else
      destination = root_path
    end
    redirect_to destination
  end

 private

  def hit_params
    { ip_address: request.remote_id, referer: request.referrer }
  end
end
