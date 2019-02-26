class GithubWebhooksController < ApplicationController
  
  # POST /author_webhook
  def author_webhook
    action = params.dig(:github_webhook, :action)
    issue = params.dig(:issue)
    case action
    when "opened"
      create_author(issue)
    when "edited"
      update_author(issue)
    when "deleted"
      delete_author(issue)
    end
  end

  def create_author(issue)
    Author.create_author_and_book(issue)
  end

  def update_author(issue)
    author = find_author(issue.dig(:number))
    author.update_attributes(name: issue.dig(:title), biography: issue.dig(:body)) if author
  end

  def delete_author(issue)
    author = find_author(issue.dig(:number))
    author.destroy if author
  end

  private

  def find_author(id)
    Author.find_by(github_id: id)
  end
end
