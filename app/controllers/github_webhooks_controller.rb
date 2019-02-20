class GithubWebhooksController < ApplicationController
  def author_webhook
    action = params["github_webhook"]["action"]
    case action
    when "opend"
      create_author(params["issue"])
    when "edited"
      update_author(params["issue"]) 
    when "deleted"
      delete_author(params["issue"])  
    end
  end

  def create_author(issue)
    author = Author.create(name: issue["title"], biography: issue["body"], github_id: issue["number"])
    Book.create(title: author.name, author: author, publisher: author)
  end

  def update_author(issue)
    author = set_author(issue["number"])	
    author.update_attributes(name: issue["title"], biography: issue["body"]) if author   	
  end

  def delete_author(issue)
    author = set_author(issue["number"])
    author.destroy if author
  end

  private
  def set_author(id)
    Author.find_by_github_id(id)	
  end
end
