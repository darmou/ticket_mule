class Status < ActiveRecord::Base
  acts_as_reportable
  # Associations
  has_many :tickets

  # Scopes
  scope :open, :conditions => "name = 'Open'"
  scope :closed, :conditions => "name = 'Closed'"
  scope :enabled, :order => 'name', :conditions => { :disabled_at => nil }
  scope :disabled, :order => 'name', :conditions => ['disabled_at IS NOT NULL']

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  def enabled?
    disabled_at.blank?
  end

end
