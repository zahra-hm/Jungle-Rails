class Admin::DashboardController < ApplicationController
  def show
    @totalNumProduct = Product.sum(:quanitity)
    @totalNumCategories = Category.count
  end
end
