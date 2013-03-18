module Wordpressto

  class Error < StandardError ; end
  class ConnectionFailure < Error ; end

  class Base

    def blog_id
      Wordpressto::Config.instance.blog_id || 1
    end

    def username
      Wordpressto::Config.instance.username
    end

    def password
      Wordpressto::Config.instance.password
    end

    def url
      Wordpressto::Config.instance.url
    end

    def recent_posts(options={})
      options[:number] ||= options.delete(:limit) || 10000
      call('wp.getPosts', blog_id, username, password, options)
    end

    def find_post(post_id)
      call('wp.getPost', blog_id, username, password, post_id)
    end

    def edit_post(qid, attributes, published = nil)
      cargs = ['metaWeblog.editPost', qid, username, password, attributes]
      cargs << published unless published.nil?
      call(*cargs)
    end

    def new_post(attributes, published = nil)
      cargs = ['metaWeblog.newPost', blog_id, username, password, attributes]
      cargs << published unless published.nil?
      call(*cargs)
    end

    def upload_file(name, mimetype, bits, overwrite = false)
      call('wp.uploadFile', blog_id, username, password,
           { :name => name, :type => mimetype, :bits => XMLRPC::Base64.new(bits), :overwrite => overwrite })
    end

    def call(*args)
      xmlrpc.call(*args)
    rescue XMLRPC::FaultException => e
      if e.message =~ /XML-RPC services are disabled/
        raise Wordpressto::ConnectionFailure, e.message
      else
        raise Wordpressto::Error, e.message
      end
    end

    def xmlrpc
      @xclient ||= XMLRPC::Client.new2(url)
    end

  end
end
