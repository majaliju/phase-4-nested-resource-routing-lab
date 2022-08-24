class ItemsController < ApplicationController
  def index
    user = User.find_by(id: params[:user_id])

    if user
      render json: user.items
    elsif params[:user_id]
      render_not_found
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  def show
    user = User.find_by(id: params[:user_id])
    item = Item.find_by(id: params[:id])

    if item
      render json: item
    elsif params[:user_id]
      render_not_found
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  end

  private

  def render_not_found
    render json: { error: "User not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
end
