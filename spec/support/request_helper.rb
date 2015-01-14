module RequestHelper
  def ensure_path path
    expect(page.current_path).to eq path
  end
  def visit_path path
    visit path
    expect(status_code).to be 200
    expect(page).not_to have_css(".translation_missing")
    ensure_path path
  end
end

RSpec.configure do |config|
  config.include RequestHelper
end
