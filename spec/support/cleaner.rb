
RSpec.configure do |config|
  config.before(:context) do
    WikiPage.init_wiki
  end
  config.after(:context) do
    FileUtils.rm_r(WikiPage.wiki.path.to_s) if WikiPage.wiki.path.exist?
  end
end
