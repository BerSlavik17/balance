class ItemsController < ApplicationController
  helper_method :collection, :resource, :items, :consolidates

  def create
		respond_to do |format|
			format.js do
				@item = Item.new(_params).decorate

				unless @item.save
					render :new
				end
			end
		end
  end

	def update
		respond_to do |format|
			format.js do
				if resource.update_attributes(_params)
					render :update
				else
					render :edit
				end
			end
		end
	end

	def destroy
		respond_to do |format|
			format.js do
				resource.destroy
			end
		end
	end

  private
  def collection
    items DateRange.new(DateFactory.build params).month
  end

  def resource
    @item ||= Item.find(params[:id]).decorate
  end

  def items date_range
    @items ||= Draper::CollectionDecorator.new Item.search(date_range, params[:category]).includes(:category)
  end

  def consolidates
    @consolidates ||= Consolidate.by DateRange.new(DateFactory.build params).month
  end

  def _params
    params.require(:item).permit(:date, :formula, :category_id, :description)
  end

  def update_resource object, attributes
    object.update_attributes attributes
  end
end
