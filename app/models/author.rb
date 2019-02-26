class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :published, foreign_key: :publisher_id, class_name: 'Book', as: :publisher
  
  def discount
    10 
  end

  def self.create_author_and_book(issue)
    ActiveRecord::Base.transaction do
      author = Author.create(name: issue.dig(:title), biography: issue.dig(:body), github_id: issue.dig(:number))
      author.books.create(title: Faker::Book.title, publisher: author)
    end
  end
end
