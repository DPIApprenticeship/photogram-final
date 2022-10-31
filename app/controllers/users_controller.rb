class UsersController < ApplicationController
  def index
    @users = User.all.order(:username, :asc)
    render({:template => "users/index.html.erb"})
  end

  def show
    if @current_user
      username = params.fetch(:username)
      if params.key?(:photos_to_show)
        params_value = params.fetch(:photos_to_show)
      else
        params_value = nil
      end
      
      
      # current_uri = request.env['PATH_INFO']
      @user = User.where(:username => username).first
      
      if params_value == "liked_photos"
        @photos = @user.liked_photos
      elsif params_value == "feed"
        @photos = @user.feed
      elsif params_value == "discover"
        @photos = @user.discovery
      else
        @photos = @user.photos
      end

      render({:template => "users/show.html.erb"})
    else
      redirect_to("/user_sign_in", { :notice => "You must sign in first." })
    end

  end

end
