#!/usr/bin/env ruby

require 'optparse'

class CodeRepositoryUpdater
    @dryRun = false
    @depth = 1
    @verbose = false

    def initialize()
        options = {}

        parser = OptionParser.new do |opts|
            options[:dryRun] = false

            opts.on('-r', '--dry-run', 'dry run mode that doesnt fetch updates') do
                options[:dryRun] = true
                puts 'dry-run'
            end

            options[:verbose] = false

            opts.on('-v', '--verbose', 'print some more verbose messages') do
                options[:verbose] = true
                puts 'verbose'
            end

            options[:depth] = 1

            opts.on('-d', '--depth NUMBER', 'directory depth to update repositories in') do |depth|
                options[:depth] = depth
                puts 'depth: ' + depth
            end

            opts.on('-h', '--help', 'list available arguments and their description') do
                puts opts; exit
            end

            opts.parse!
        end

        @dryRun = options[:dryRun]
        @depth = options[:depth]
        @verbose = options[:verbose]
    end

    def is_directory(name)
        if File.directory?(name)
            return true
        end

        false
    end

    def is_subdirectory(name)
        if name != '.' && name != '..'
            return true
        end

        false
    end

    def is_git_repository(path)
        Dir.foreach(path) do |item|
            if '.git' == item
                return true
            end
        end

        false
    end

    def is_svn_repository(path)
        Dir.foreach(path) do |item|
            if '.svn' == item
                return true
            end
        end

        false
    end

    def is_hg_repository(path)
        Dir.foreach(path) do |item|
            if '.hg' == item
                return true
            end
        end

        false
    end

    def update_git_repository
        if @dryRun
            puts 'Running in test mode'
        else
            output = `git pull --rebase`
            puts output
        end
    end

    def update_svn_repository
        if @dryRun
            puts 'Running in test mode'
        else
            output = `svn update`
            puts output
        end
    end

    def update_hg_repository
        if @dryRun
            puts 'Running in test mode'
        else
            output = `hg pull --rebase`
            puts output
        end
    end

    def check_for_git_remotes
        output = `git remote`

        if !output.empty?
            return true
        end

        false
    end

    def main
        glob = '*'
        depth = @depth.to_i - 1

        for i in 1..depth
            glob += '/*'
        end

        dirs = Dir.glob(glob).select
        pwd = Dir.pwd

        for dir in dirs
            path = pwd + '/' + dir

            if is_directory(path)
                if is_git_repository(path)
                    Dir.chdir(path)
                    isRepoWithRemotes = check_for_git_remotes

                    if isRepoWithRemotes
                        puts 'Updating ' + dir
                        update_git_repository
                    end
                elsif is_svn_repository(path)
                    Dir.chdir(path)
                    puts 'Updating ' + dir
                    update_svn_repository
                elsif is_hg_repository(path)
                    Dir.chdir(path)
                    puts 'Updating ' + dir
                    update_hg_repository
                else
                    puts 'Unrecognized ' + dir
                end
            end
        end

        0
    end
end

git_updater = CodeRepositoryUpdater.new
git_updater.main
