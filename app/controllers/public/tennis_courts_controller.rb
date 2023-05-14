class Public::TennisCourtsController < ApplicationController
  def index
    @tennis_courts = TennisCourt.all
    
  end
end
