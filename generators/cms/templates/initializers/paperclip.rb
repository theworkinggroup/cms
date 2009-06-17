class Paperclip::Attachment
  def self.default_options
    @default_options ||= {
      :url           => "/system/:attachment/:id/:style/:filename",
      :path          => ":rails_root/public:url",
      :styles        => {},
      :default_url   => "/:attachment/:style/missing.png",
      :default_style => :original,
      :validations   => [],
      :storage       => :filesystem,
      :whiny         => Paperclip.options[:whiny] || Paperclip.options[:whiny_thumbnails]
    }
  end
end