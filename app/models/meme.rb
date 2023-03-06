class Meme < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :url
    validates :top_text, presence: true
    validates :bottom_text, presence: true
end