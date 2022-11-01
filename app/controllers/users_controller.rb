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
      requested_follow = FollowRequest.where(:sender_id => @current_user.id).where(:recipient_id => @user.id)
      @already_followed = requested_follow.count > 0
      
      
      if params_value == "liked_photos"
        @display = "Liked Photos (#{@user.liked_photos.count})"
        @photos = @user.liked_photos
      elsif params_value == "feed"
        @display = "Feed (#{@user.feed.count})"
        @photos = @user.feed
      elsif params_value == "discover"
        @display = "Discover (#{@user.discovery.count})"
        @photos = @user.discovery
      else
        @display = "Own Photos (#{@user.photos.count})"
        @photos = @user.photos
      end

      if @user.private
        if @already_followed && requested_follow.first.status == "accepted" || @user == @current_user
          render({:template => "users/show.html.erb"})
        else
          redirect_to("/users", {:notice => "You have to sign in first."})
        end
      else
        render({:template => "users/show.html.erb"})
      end


    else
      redirect_to("/user_sign_in", { :notice => "You must sign in first." })
    end

  end

end
