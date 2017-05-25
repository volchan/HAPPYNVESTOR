class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @search = Search.new
    @types = Type.all.order(name: :asc)

    # Search.find(9).results.create
  end

end
