all:
	docker build -t tmp .
	docker run -it --rm tmp > xz
	chmod +x xz
