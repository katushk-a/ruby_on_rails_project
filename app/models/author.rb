class Author < ApplicationRecord
    has_many :articles, dependent: :destroy
  
    validates :email, presence: true, uniqueness: true

    def full_name
        "#{first_name} #{last_name}"
      end
end
