vim:
	vim -o app/app.coffee

push:
	rsync --recursive --verbose --delete public prod:~/flutter
