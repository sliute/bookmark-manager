require 'data_mapper'
require './bookmark_manager.rb'

namespace :db do
  desc "Auto upgrade!"
  task :auto_upgrade do
    DataMapper.auto_upgrade!
    p "Auto-upgraded (non-distructive)."
  end

  desc "Auto migrate!"
  task :auto_migrate do
    DataMapper.auto_migrate!
    p "Auto-migrated (distructive)."
  end
end
