class GithubWebhooksController < ApplicationController
  # POST /author_webhook
  def author_webhook
    action = params['github_webhook']['action']
    case action
    when 'opened'
      create_author(params['issue'])
    when 'edited'
      update_author(params['issue'])
    when 'deleted'
      delete_author(params['issue'])
    end
  end

  def create_author(issue)
    author = Author.create(name: issue['title'], biography: issue['body'], github_id: issue['number'])
    author.books.create(title: author.name, publisher: author)
  end

  def update_author(issue)
    author = find_author(issue['number'])
    author&.update_attributes(name: issue['title'], biography: issue['body'])
  end

  def delete_author(issue)
    author = find_author(issue['number'])
    author&.destroy
  end

  private

  def find_author(id)
    Author.find_by_github_id(id)
  end
end
