# frozen_string_literal: true

require 'flickraw'

class StaticPagesController < ApplicationController
  FlickRaw.api_key = ENV['FLICKRAW_API_KEY']
  FlickRaw.shared_secret = ENV['FLICKRAW_SHARED_SECRET']

  def home
    if params[:flickr].present?
      user_id = params[:flickr][:user_id]
      begin
        @photos = flickr.people.getPhotosOf(user_id: user_id, extras: 'url_m')
      rescue FlickRaw::FailedResponse
        flash.now[:danger] = 'Sorry, but the user does not exist.'
        render :home
      end
    end
  end
end
