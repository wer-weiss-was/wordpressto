module Wordpressto
  class WordpressPostCollection < Base
    def find_recent(options = { })
      options = { :limit => 10 }.merge(options)
      posts = conn.get_recent_posts(options[:limit])
      posts.collect { |post|  WordpressPost.new(post, :conn => conn) }
    end

    def find(qid, options = { })
      if qid.is_a?(Array)
        qid.collect { |sqid| find(sqid) }
      elsif qid == :recent
        find_recent(options)
      else
        post = conn.get_post(qid)
        WordpressPost.new(post, :conn => conn)
      end
    end

    def new(attributes = { })
      WordpressPost.new(attributes, :conn => conn)
    end

  end
end