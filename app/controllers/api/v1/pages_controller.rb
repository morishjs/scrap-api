class Api::V1::PagesController < ApplicationController
  def index
    @pages = Page.all
  end
end