namespace :db do
  desc "Load seed fixtures (from db/fixtures) into the current environment's database." 
  task :seed => :environment do
    require 'active_record/fixtures'
    Dir.glob(RAILS_ROOT + '/db/fixtures/*.yml').each do |file|
      Fixtures.create_fixtures('db/fixtures', File.basename(file, '.*'))
    end
    
    #Post-processing of data
    Page.rebuild_tree
    Group.rebuild_tree
    Membership.rebuild_memberships
    Tag.find(:all).each do |tag|
      tag.taggings_count = tag.taggings.count
      tag.save
    end 
  end
end
