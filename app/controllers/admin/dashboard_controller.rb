class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_BASIC_USER"], password: ENV["HTTP_BASIC_PASSWORD"]
  def show
    @total_prod = Product.count()
    @total_cate = Category.count()
  end
end
