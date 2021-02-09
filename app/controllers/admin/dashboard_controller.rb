class Admin::DashboardController < ApplicationController
  def show
    @totalNumProduct = Product.sum(:quantity)
    @totalNumCategories = Category.count
  end
end
