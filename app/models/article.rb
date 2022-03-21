class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: {minimum:6, maximum:100}
  validates :description, presence: true, length: {minimum:10, maximum:300}
end


# model name:Article
# article model class name:Article
# article model file name:article.rb
# table name: articles