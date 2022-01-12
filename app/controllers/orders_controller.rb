class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  def enhanced_order
    @enhanced_order ||= @order.line_items.map{|line_item| {quantity: line_item.quantity, product: Product.find_by(id:line_item.product_id)}}
  end
  helper_method :enhanced_order

  def order_subtotal_cents
    enhanced_order.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :order_subtotal_cents

  
  private
  
  
  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end
  
  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end
  
  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )
    
    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end
  
  def get_email
    @order.map {|e| e[:email]}
  end
  helper_method :get_email

end
