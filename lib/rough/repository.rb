require 'rugged'

module Rough
  class Repository

    def self.create(path)
      repo = Rugged::Repository.init_at(path, false)

      new path, repo
    end

    def self.fetch(path)
      repo = Rugged::Repository.new(path)

      new path, repo
    end

    attr_reader :path, :repo

    def initialize(path, repo)
      @path, @repo = path, repo
    end

    def create_file(path, content)
      File.open("#{repo.workdir}#{path}", 'w') do |f|
        f.write content
      end

      index.add(path)
      index.write
    end

    def commit(author, message)
      options = {}
      options[:tree] = index.write_tree(repo)

      options[:author] = { :email => author[:email], :name => author[:name], :time => Time.now }
      options[:committer] = { :email => author[:email], :name => author[:name], :time => Time.now }
      options[:message] ||= message
      options[:parents] = repo.empty? ? [] : [ repo.head.target ].compact
      options[:update_ref] = 'HEAD'

      Rugged::Commit.create(repo, options)
    end

    private

    def index
      repo.index
    end
  end
end