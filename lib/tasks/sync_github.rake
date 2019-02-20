namespace :sync_github do
  desc "Sync up with github"
  task :author_details => :environment do
    require 'net/http'
    issues = Net::HTTP.get(URI.parse('https://api.github.com/repos/ansh-k/bookstore-api/issues'))
    issues = JSON.parse issues
    issues.each do |issue|
      author = Author.find_by_github_id(issue["number"])    
      if author.blank?
        Author.create(name: issue["title"], biography: issue["body"], github_id: issue["number"])
      else
        author.update_attributes(name: issue["title"], biography: issue["body"])
      end
    end
  end
end  