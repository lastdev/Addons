TOC =		AchievementLocations-1.0.toc
DERIVED =	$(shell sed -ne '/^AchievementLocations_/p' $(TOC))


all: derive

derive:
	coffee make.coffee

.PHONY: all
