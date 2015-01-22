module WikiHelper
  def page_rows page
    rows = page.content.split.length + 5
    rows > 30 ? 30 : rows
  end
  def filter page
    context = {       :base_url   => "/wiki"     }
    #      :asset_root => "http://your-domain.com/where/your/images/live/icons",
    #:base_url   => engine.root
    simple = HTML::Pipeline.new [ 
                            HTML::Pipeline::MarkdownFilter,
                            HTML::Pipeline::WikiLinkFilter ,
                            HTML::Pipeline::TableOfContentsFilter, 
                            HTML::Pipeline::SanitizationFilter,
                            #HTML::Pipeline::EmojiFilter,
                            HTML::Pipeline::AutolinkFilter, 
                            ], context
    simple.call(page.content)[:output].to_s
  end
end
