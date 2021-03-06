class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_item_index
  before_action :set_item

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      @order_address.save
      pay_item
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      token: params[:token], user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: @order_address.token,
      currency: 'jpy'
    )
  end

  def move_to_item_index
    item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == item.user_id || item.order
  end
end
