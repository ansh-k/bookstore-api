namespace :sync_github do

  # This task fetch issues details and create author and book on our DB 
  desc "Sync db from github"
  task :author_details_from_github => :environment do
    issues = Github.new.issues.list user: ENV['USERNAME'], repo: ENV['REPOSITORY']
    issues.each do |issue|
      author = Author.find_by_github_id(issue["number"])    
      if author.blank?
        author = Author.create(name: issue["title"], biography: issue["body"], github_id: issue["number"])
        author.books.create(title: author.name, publisher: author)
      else
        author.update_attributes(name: issue["title"], biography: issue["body"])
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
