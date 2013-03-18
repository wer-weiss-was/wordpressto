module Wordpressto
  class WordpressAttachmentCollection < Base
    def new(attributes)
      WordpressAttachment.new(attributes)
    end
  end
end