set :domain, 'reformeter.forset.ge'
set :user, 'reformeter'
set :application, 'Reformeter'
# easier to use https; if you use ssh then you have to create key on server
set :repository, 'https://github.com/ForSetGeorgia/ReforMeter.git'
set :branch, 'master'
set :web_url, 'reformeter.iset-pi.ge'
set :secondary_web_url, 'reformeter.forset.ge'
set :use_ssl, true
set :puma_worker_count, '1'
set :puma_thread_count_min, '1'
set :puma_thread_count_max, '16'
