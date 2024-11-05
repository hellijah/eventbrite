class PagesController < ApplicationController

  def home
    UserMailer.contact(Post.first).deliver_later
  end

end