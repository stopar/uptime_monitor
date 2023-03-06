class Domain < ApplicationRecord
  include ActionView::RecordIdentifier
  
  has_many :pings, dependent: :destroy
  
  validates :name, format: { with: /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}/ }, uniqueness: true
  
  after_update_commit do
    broadcast_update_to(dom_id(self), partial: "domains/monitoring", locals: { domain: self}, target: "monitoring" )
    # broadcast_prepend_to(dom_id(self), partial: "layouts/flash" )
  end
end
