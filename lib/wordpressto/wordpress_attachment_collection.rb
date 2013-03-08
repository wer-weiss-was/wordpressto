module Wordpressto
  class WordpressAttachmentCollection < Base
    def new(attributes)
      WordpressAttachment.new(attributes, :conn => conn)
    end
  end
end