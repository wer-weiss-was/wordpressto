require 'wordpressto/category'
module Wordpressto
  class CategoryCollection < Base
    include Enumerable

    def initialize(*args)
      super(*args)
    end

    def all
      @categories ||= load
    end

    # retrieve the categories via xmlrpc
    def load
      cats = []
      call('wp.getCategories', blog_id, username, password).each do |c|
        cats << Category.new_from_xmlrpc(c)
      end
      @categories = cats
    end

    def [](i)
      all[i]
    end

    def each
      all.each { |c| yield c }
    end

    def create(attributes)
      new_cat = Category.new(attributes)
      new_cat.save
      new_cat
    end
  end
end
