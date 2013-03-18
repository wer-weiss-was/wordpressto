module Wordpressto
  class WordpressPostCollection < Base
    def all(options={})
      posts = recent_posts(options)
      posts.collect { |post|  WordpressPost.new(post) }
    end

    def find(post_id)
      if post_id.is_a?(Array)
        post_id.collect { |sqid| find(sqid) }
      else
        post = find_post(post_id)
        WordpressPost.new(post)
      end
    end

    def new(attributes = { })
      WordpressPost.new(attributes)
    end

  end
end