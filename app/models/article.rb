class Article < ApplicationRecord
    include Visible
  
    belongs_to :author, required: true
    has_many :comments, dependent: :destroy
  
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }
  end
  