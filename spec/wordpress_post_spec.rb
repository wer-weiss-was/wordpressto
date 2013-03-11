require File.join(File.dirname(__FILE__), 'spec_helper')

describe WordpressPost do

  context 'initialize' do
    it 'should initialize from json' do
      post_data = { post_id:        1234,
                    post_title:     'foo bar',
                    post_date:      XMLRPC::DateTime.new(2013,2,27,9,18,41),
                    post_modified:  XMLRPC::DateTime.new(2013,2,27,9,18,41),
                    post_status:    'publish',
                    post_content:   '<div>Viel HTML</div>',
                    post_author:    '3',
                    terms:          [
                                      {
                                          term_id:      "123",
                                          name:         "Tagging",
                                          taxonomy:     "post_tag"
                                      },
                                      {
                                          term_id:      "124",
                                          name:         "Experte",
                                          taxonomy:     "category"
                                      },
                                      {
                                          term_id:      "125",
                                          name:         "Tagging2",
                                          taxonomy:     "post_tag"
                                      },
                                    ],
                    custom_fields:  [
                                      {
                                          id:           "345",
                                          key:          "homepage_teaser",
                                          value:        "<div>Fooooooo</div>"
                                      },
                                      {
                                          id:           "344",
                                          key:          "foo",
                                          value:        "bar"
                                      }
                                    ]
                  }

      @post = WordpressPost.new(post_data)
      @post.title.should == 'foo bar'
      @post.keywords.should == ['Tagging', 'Tagging2']
      @post.categories.should == ['Experte']
      @post.created_at.should == Time.gm(2013,2,27,9,18,41)
      @post.description.should == '<div>Viel HTML</div>'
      @post.id.should == 1234
      @post.published.should == 'publish'
      @post.updated_at.should == Time.gm(2013,2,27,9,18,41)
      @post.custom_fields.should == { "homepage_teaser" => "<div>Fooooooo</div>", "foo" => 'bar' }
    end

  end

end