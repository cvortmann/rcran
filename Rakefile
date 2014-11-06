require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :packages do
  require './jobs/download_versions_job'
  Mongoid.load!("config/mongoid.yml", :development)

  desc "Download package list and store them in the db"
  task :download do
    DownloadVersionsJob.new.run
  end

  desc "scheduled download"
  task :job do
    require 'rufus-scheduler'

    scheduler = Rufus::Scheduler.new

    scheduler.cron "0 12 * * *" do
      puts "Downloading and saving packages"
      DownloadVersionsJob.new.run
      puts "Saving packages done!"
    end

    scheduler.join
  end
end
