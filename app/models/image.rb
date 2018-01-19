class Image < ApplicationRecord
  has_attached_file :attachment, styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }, 
                                 default_url: "/images/:style/missing.png"
  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\z/
  belogns_to :listing
end