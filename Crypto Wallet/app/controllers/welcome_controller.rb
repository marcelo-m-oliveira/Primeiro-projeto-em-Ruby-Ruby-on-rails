class WelcomeController < ApplicationController

  def index
    cookies[:curso] = "Ruby on Rails"
    session[:curso] = "Ruby on Rails"
    @curso = params[:curso]
    @nome = "Marcelo"
  end

end
