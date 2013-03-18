module Wordpressto
  class Category < Base
    attr_reader :id, :category_id, :description, :name, :rss_url

    def initialize(attributes = {}, options = {})
      @id = attributes[:id]
      @category_id = attributes[:category_id] || 0
      @description = attributes[:description]
      @name = attributes[:name]
      @url = attributes[:url]
      @rss_url = attributes[:rss_url]
      @slug = attributes[:slug]
    end

    def self.new_from_xmlrpc(attributes, options = {})
      self.new( { :id => attributes['categoryId'], :category_id => attributes['parentId'],
                  :description => attributes['description'], :name => attributes['categoryName'],
                  :url => attributes['htmlUrl'], :rss_url => attributes['rssUrl'] },
                options )
    end

    def save
      @id = call 'wp.newCategory', blog_id, username, password, to_xmlrpc_struct
    end

    def to_xmlrpc_struct
      { "name" => name, "slug" => slug, "parent_id" => category_id, "description" => description.to_s }
    end

    def slug
      @slug ||= @name.to_s.downcase.strip.gsub(/\s/, '-')
    end
  end
end

