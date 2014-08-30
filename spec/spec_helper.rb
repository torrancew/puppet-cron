require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'

def get_timestamp( params = {} )
  stamp = ''
  [ :minute, :hour, :date, :month, :weekday ].each do |k|
    stamp << "#{params[k] || '*'} "
  end
  return stamp.strip
end

def get_cronline( job = {} ) 
    cronline = '' 
    [ 'minute', 'hour', 'date', 'month', 'weekday', 'user', 'command' ].each do |k|  
      cronline << "#{job[k]} " 
    end  
    return cronline.strip 
end 
