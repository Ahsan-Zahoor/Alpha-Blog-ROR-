class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum:6, maximum:100}
  validates :description, presence: true, length: {minimum:10, maximum:300}
end


# model name:Article
# article model file name:article.rb
# article model class name:Article
# table name: articles