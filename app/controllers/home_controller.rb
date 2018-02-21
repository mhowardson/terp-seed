class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [ :index ]
  
  def index
  end
  
  def set_locale
    session[:locale] = params[:locale]
    redirect_to :back
  end
end
