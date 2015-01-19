
RSpec.configure do |config|
  config.before(:each) do
    WikiPage.init_wiki
  end
  config.after(:each) do
    FileUtils.rm_r(WikiPage.wiki.path.to_s) if WikiPage.wiki.path.exist?
  end
end
