set :domain, '139.162.208.211' #beta.forset.ge
set :user, 'deploy'
set :application, 'ReforMeter-Staging'
# easier to use https; if you use ssh then you have to create key on server
set :repository, 'https://github.com/ForSetGeorgia/ReforMeter.git'
set :branch, 'master'
set :web_url, 'dev-reformeter.forset.ge'
set :visible_to_robots, false
set :use_ssl, false
