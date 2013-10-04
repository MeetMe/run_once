#
# Cookbook Name:: run_once
# Library:: run_once
#
# Copyright 2013, MeetMe, Inc.
#
module RunOnce

  @run_once_file = '/var/chef/cache/run_once.json'

  #######
  # Is Run Once Ran Flag Set?

  # Function that indicates if the particular run_once value for a cookbook
  # flag is set and true
  def self.had_run?(cookbook, flag)
    had_run = false
    if Chef::Config[:solo]
      if File::exists?(@run_once_file)
        values = JSON.parse(IO.read(@run_once_file))
        had_run = values.key?(cookbook) && values[cookbook].key?(flag) && values[cookbook][flag]
      else
      end
    else
      had_run = node.attribute?(:run_once) &&
          node[:run_once].attribute?(cookbook) &&
          node[:run_once][cookbook].attribute?(flag) &&
          node[:run_once][cookbook][flag]
    end
    Chef::Log.debug("had_run: #{had_run}")
    had_run
  end

  #######
  # Set Run Once Ran Flag

  # Function that sets the run once ran value for the cookbook and flag
  def self.ran(cookbook, flag)
    if Chef::Config[:solo]
      if File::exists?(@run_once_file)
        values = JSON.parse(IO.read(@run_once_file))
        values[cookbook.to_s] = {flag.to_s => true}
      else
        values = {cookbook => {flag => true}}
      end
      File.open(@run_once_file, 'w') do |f|
          JSON.dump(values, f)
      end
    else
      node.set[:run_once][cookbook][flag] = true
    end
  end

end
