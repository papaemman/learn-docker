setup:
	poetry install --no-root

run_app:
	poetry run python app/run_app.py

run_app_gunicorn:
	cd app && poetry run gunicorn --bind 0.0.0.0:8050 run_app:server


test_app_before_commit:
	@echo "Testing docker image before pushing..."
	docker build -t docker-image-name -f Dockerfile .
	docker stop docker-image-name || true && docker rm docker-image-name || true
	docker run -d --name docker-image-name -p 8050:8050 docker-image-name
	@echo "Open http://localhost:8050/ in your browser to see the app running..."