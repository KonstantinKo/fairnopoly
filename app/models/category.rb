class Category < ActiveRecord::Base
  
  attr_accessible :name, :parent, :desc, :parent_id
  
  has_many :auctions_categories
  has_many :auctions, :through => :auctions_categories
  
  # Doesn't work with our category tree
  #validates :name, :uniqueness => true
  
  acts_as_nested_set
  
  # recursively determines whether the passed collection includes all ancestors of self
  # without hitting the db
  def include_all_ancestors?(categories)
    categories = categories.all unless categories.is_a?(Array)
    return true unless parent_id
    p = categories.select{|c| c.id == self.parent_id}.first
    if p
      p.include_all_ancestors?(categories)
    else
      false
    end
  end
  
end
