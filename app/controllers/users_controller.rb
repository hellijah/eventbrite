class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def new
  end

  def create
  end

  def show
    @user = User.find(params[:id])
  end
end
