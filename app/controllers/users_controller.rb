class UsersController < ApplicationController
  def index
    @users = User.all.order(:username, :asc)
    render({:template => "users/index.html.erb"})
  end

  def show
    username = params.fetch(:username)
    @user = User.where(:username => username).first
    render({:template => "users/show.html.erb"})
  end
end
