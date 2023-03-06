class Ping < ApplicationRecord
  include ActionView::RecordIdentifier
  belongs_to :domain
  
  scope :order_last_out_first, -> { order(created_at: :desc) }
  
  after_create_commit do
    broadcast_prepend_to(dom_id(domain), partial: "pings/ping", locals: { ping: self, domain: domain }, target: "pings" )
  end
end
