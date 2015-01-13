module GollumRails
  module PathHelpers
    def self.configure_path(path)
      return path if path.starts_with?("/")
      Rails.root.join(path)
    end
  end
end