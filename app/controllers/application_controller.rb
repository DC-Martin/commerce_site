class ApplicationController < ActionController::Base

  before_action :categories, :brands
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  def categories
    @categories = Category.order(:name)
  end

  def brands
    @brands = Product.pluck(:brand).sort.uniq
  end

  def cart_count
    @cart_count = LineItem.all.length
  end
  
end
