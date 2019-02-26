namespace :sync_github do

  # This task fetch issues details and create author and book on our DB 
  desc "Sync db from github"
  task :author_details_from_github => :environment do
    issues = Github.new.issues.list user: ENV['USERNAME'], repo: ENV['REPOSITORY'], oauth_token: ENV['OAUTH']
    issues.each do |issue|
      author = Author.find_by(github_id: issue.dig(:number))    
      if author.blank?
        Author.create_author_and_book(issue)
      else
        author.update_attributes(name: issue.dig(:title), biography: issue.dig(:body))
      end
    end
  end

  # This task update github with our DB data
  desc "Sync github from db"
  task :author_details_to_github => :environment do
    github = Github.new user: ENV['USERNAME'], repo: ENV['REPOSITORY'], oauth_token: ENV['OAUTH']
    authors = Author.where(github_id: nil)
    authors.each do |author|
      response = github.issues.create(title: author.name, body: author.biography)        
      author.update_attribute(:github_id, response.number)
    end
  end
end
