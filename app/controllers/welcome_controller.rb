
  class WelcomeController < ApplicationController
  def index
    flash[:warning] = "睡觉吧！"
  end
end
