class ItemsController < InheritedResources::Base
  include InheritedResources::DSL

  respond_to :js
  respond_to :html, :only => :index

  actions :all, :except => :index

  before_filter :find_cashes, :find_items, :find_consolidates, :only => :index

  create! do |success, failure|
    success.js do
      # в before_filter это выносить не стоит. 
      # потому что пересчет сводного отчета должен происходить 
      # после успешного создания записи
      @consolidates = find_consolidates
    end
  end

  update! do |success, failure|
    success.js do
      # в before_filter это выносить не стоит. 
      # потому что пересчет сводного отчета должен происходить 
      # после успешного обновления записи
      @consolidates = find_consolidates
    end
  end

  private
  def find_cashes
    @cashes = Cash.scoped
  end

  def find_items
    @items = Item.search_by params
  end

  def find_consolidates
    @consolidates = Item.consolidates params
  end
end
