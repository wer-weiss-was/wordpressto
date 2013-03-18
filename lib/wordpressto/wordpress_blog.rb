module Wordpressto
  class WordpressBlog < Base

    def initialize(options = { })
      Wordpressto::Config.instance.update!(options)
    end

    def posts
      @post_collection ||= WordpressPostCollection.new
    end

    def attachments
      @attachments ||= WordpressAttachmentCollection.new
    end

    def categories
      @categories ||= CategoryCollection.new
    end

  end
end