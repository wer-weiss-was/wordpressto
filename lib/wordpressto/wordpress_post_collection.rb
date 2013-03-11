module Wordpressto
  class WordpressPostCollection < Base
    def all(options={})
      posts = conn.get_recent_posts(options)
      posts.collect { |post|  WordpressPost.new(post, :conn => conn) }
    end

    def find(post_id)
      if post_id.is_a?(Array)
        post_id.collect { |sqid| find(sqid) }
      else
        post = conn.find_post(post_id)
        WordpressPost.new(post, :conn => conn)
      end
    end

    def new(attributes = { })
      WordpressPost.new(attributes, :conn => conn)
    end

  end
end