run:
	sudo docker compose up --build -d

cleanup:
	sudo docker compose down && \
	sudo rm -rf database/data/*

