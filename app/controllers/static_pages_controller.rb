class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:secret]
  
  def index
    @events = Event.all
  end

  def secret
  end
end
