web: bundle exec rails server -p ${PORT:-3000} -e development
worker: bundle exec rake environment resque:work QUEUE=* 
scheduler: bundle exec rake resque:scheduler