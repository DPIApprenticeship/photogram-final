class UsersController < ApplicationController
  def index
    render({:template => "users/index.html.erb"})
  end
end
