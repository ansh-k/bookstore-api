# README

## Base install
1. Clone repository
	```
    https://github.com/ansh-k/bookstore-api.git
	```
1. Change to directory:
	```
	cd bookmark-api
	```
1. Copy the `.sample.env` file as `.env` and then add your actual values into
the `.env` file, and we don't track that file through source control.
	```
	cp .sample.env .env
	```
1. Install required gems
	```
	bundle install
	```
## Database
1. Install Postgres
1. Edit /etc/postgresql/10/main/pg_hba.conf to have this line 
	```
	local   all             all                                     trust
	```
1. Restart postgres: 
	```
	sudo service postgresql restart
	```	
1. Create databases: 
	```
	rake db:create
	```
1. Run migrations:
	```
	rake db:migrate
	```
1. Populate seed data
	```
	rake db:seed
	```
1. Start server
	```
	rails s
	```