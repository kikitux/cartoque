class License
  include Mongoid::Document
  include Mongoid::Timestamps
  include ConfigurationItem

  field :editor, type: String
  field :key, type: String
  field :title, type: String
  field :quantity, type: String
  field :purshased_on, type: Date
  field :renewal_on, type: Date
  field :comment, type: String
  has_and_belongs_to_many :servers

  scope :by_editor, proc {|editor| where(editor: editor) }
  scope :by_key, proc { |term| where(key: Regexp.mask(term)) }
  scope :by_title, proc { |term| where(title: Regexp.mask(term)) }
  scope :by_server, proc { |id| where(server_ids: id) }

  validates_presence_of :editor
end
