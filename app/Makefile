.PHONY: start format sort_import

start:
	flutter pub get
	flutter run -d web-server --web-port=8888 --web-hostname=0.0.0.0

format:
	dart format ./lib

sort_import:
	flutter pub run import_sorter:main
