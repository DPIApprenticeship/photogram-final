class UsersController < ApplicationController
  def index
    @users = User.all.order(:username, :asc)
    render({:template => "users/index.html.erb"})
  end

  def show
    if @current_user
      username = params.fetch(:username)
      @user = User.where(:username => username).first
      @photos = Photo.where(:owner_id => @user.id)
      render({:template => "users/show.html.erb"})
    else
      redirect_to("/user_sign_in")
    end

  end
end
