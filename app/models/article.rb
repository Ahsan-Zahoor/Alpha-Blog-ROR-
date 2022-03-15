class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {minimum:6, maximum:100}
  validates :description, presence: true, length: {minimum:10, maximum:300}
end


# model name:Article
# article model class name:Article
# article model file name:article.rb
# table name: articles