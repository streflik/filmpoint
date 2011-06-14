class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  before_filter :find_product, :only=>[:show,:buy]
  before_filter :authenticate_user!, :except=>[:index,:show,:buy]
  before_filter :check_code, :only=>:show

  # GET /products/1
  # GET /products/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def buy
    if params[:code].present? && @product
      if code = Code.where(:value=>params[:code][:value]).first
        if code.used_at.nil?
          code.auth!
          cookies[:auth] ={:value=>params[:code][:value], :expires=>@product.cookie_exp_at}
          redirect_to product_permalink_path(:permalink=>@product.permalink)
          return
        else
         notice=t('code_has_been_used_notice')
        end
      else
        notice=t('code_invalid_notice')
      end
      redirect_to "/#{@product.permalink}/buy", :notice=>notice
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  #def destroy
  #  @product = Product.find(params[:id])
  #  @product.destroy

  #  respond_to do |format|
  #    format.html { redirect_to(products_url) }
  #   format.xml  { head :ok }
  #  end
  #end

def generate_codes
  params[:quantity].to_i.times do
    Code.create(:value=>ActiveSupport::SecureRandom.hex(3), :product_id=>params[:id]).save
  end
  redirect_to :action=>:edit
end

end

private

def find_product
  if params[:id]
    @product= Product.find params[:id]
  else
    @product = Product.find_by_permalink(params[:permalink])
  end
end

def check_code
  if (cookies[:auth] && code = Code.authorize_code(cookies[:auth]) ) || current_user.present?
    true
  else
      redirect_to "/#{@product.permalink}/buy", :notice=>t('enter_code_notice')

  end
end
