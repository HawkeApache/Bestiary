class MainController < ApplicationController
  def index
    @top_beasts = Beast.order(rating: :desc).limit(5)
    @top_subjects = Subject.order(rating: :desc).limit(5)
  end
end
