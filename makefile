main: stop start

start:
	chmod +x ./create_ssl_certificate.sh
	./create_ssl_certificate.sh
	docker-compose up

stop:
	docker-compose down

reset:
	docker-compose down --remove-orphans
	rm -rf ./wordpress

export:
	./export.sh