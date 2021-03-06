module Wordpressto
  class WordpressPost < Base
    attr_accessor :title, :description
    attr_accessor :created_at, :updated_at
    attr_accessor :keywords, :categories, :published
    attr_accessor :custom_fields

    def initialize(attributes = { })
      self.attributes = attributes
    end

    def attributes=(attr)
      symbolized_attr = { }
      attr.each { |k,v| symbolized_attr[k.to_sym] = v }
      attr = symbolized_attr
      @title = attr[:post_title]
      @keywords = taxonomy_collector(attr[:terms], 'post_tag')
      @categories = taxonomy_collector(attr[:terms], 'category')
      @description = attr[:post_content]
      @created_at = attr[:post_date].to_time
      @updated_at = attr[:post_modified].to_time
      @id = attr[:post_id].to_i
      @published = attr[:post_status]
      @custom_fields = custom_fields_hash(attr[:custom_fields])
    end

    def id
      @id
    end

    def save
      id ? update : create
    end

    def update
      edit_post(id, attributes, published)
      self
    end

    def create
      @id = new_post(attributes, published)
      self
    end

    def publish
      self.published = true
      save
    end

    def created_at
      @created_at
    end

    def attributes
      h = { }
      h[:title] = title if title
      h[:description] = description if description
      h[:dateCreated] = created_at if created_at
      h[:mt_keywords] = keywords.join(",")
      h[:categories] = categories.join(",") if categories
      h
    end

    def reload
      if id
        saved_id = id
        self.attributes = posts.find(id).attributes
        @id = saved_id
        true
      end
    end

    private

    def taxonomy_collector(terms, taxonomy)
      terms.map do |term|
        term[:name] if term[:taxonomy] == taxonomy
      end.compact
    end

    def custom_fields_hash(custom_fields)
      fields = {}
      custom_fields.each do |custom_field|
        fields[custom_field["key"]] = custom_field["value"]
      end
      fields
    end

  end
end