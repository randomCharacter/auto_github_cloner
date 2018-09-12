#!/usr/bin/ruby

require 'octokit'

if __FILE__ == $0
  unless ARGV[0]
    puts "usage: #{$0} path/to/folder"
    exit 1
  end
  repos_folder = ARGV[0]
  client = Octokit::Client.new(:access_token => ENV["GITHUB_TOKEN"], per_page: 100)
  repositories = client.repositories
  repositories.each do |repo|
    if repo.owner.login == client.login
      puts "cloning #{repo.ssh_url}"
      `git clone #{repo.ssh_url} #{repos_folder}/#{repo.name}`
    end
  end
end
