class ItemsController < InheritedResources::Base
  respond_to :js
  respond_to :html, :only => :index

  actions :all, :except => :index

  def index
    @cashes = Cash.scoped

    respond_to do |format|
      format.js do
        @items = Item.search_by params
        @consolidates = Item.consolidates params
      end

      format.html
    end
  end
end
