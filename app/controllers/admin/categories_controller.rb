class Admin::CategoriesController < ApplicationController
  
  before_filter :authenticate

  def index
    # @categories = Category.order(name :desc).all
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end

end
