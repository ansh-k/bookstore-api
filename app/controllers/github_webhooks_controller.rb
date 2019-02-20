class GithubWebhooksController < ApplicationController
  def author_webhook
    action = params["github_webhook"]["action"]
    if action == "opened"
      create_author(params["issue"])				
    elsif action == "edited"
      update_author(params["issue"])
    elsif action == "deleted"
      delete_author(params["issue"])
    else
    end
    return {}
  end

  def create_author(issue)
    Author.create(name: issue["title"], biography: issue["body"], github_id: issue["number"])
  end

  def update_author(issue)
    author = set_author(issue["number"])	
    author.update_attributes(name: issue["title"], biography: issue["body"])    	
  end

  def delete_author(issue)
    author = set_author(issue["number"])
    author.destroy
  end

  private
  def set_author(id)
    Author.find_by_github_id(id)	
  end
end
