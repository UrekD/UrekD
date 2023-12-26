# Makefile

include config.env

.PHONY: run-query

run-query:
	VALUES="$$(docker exec -it $(DB_CONTAINER) mysql -u $(DB_USER) -p$(DB_PASSWORD) -Nse 'USE $(DB_NAME); SELECT COUNT(*) FROM guilds; SELECT COUNT(*) FROM mods; SELECT COUNT(*) FROM link;' 2>&1 | grep -v 'Warning' | tr -s '\n' ' ')" && \
	echo "Values: $$VALUES" && \
	TODAY="$$(date +'%d/%m/%Y')" && \
	echo "Today: $$TODAY" && \
	cp template.svg overview.svg && \
	sed -i -e "s|X0|$${TODAY}|g" \
			-e "s|X1|$$(echo $$VALUES | awk '{print $$1}')|g" \
			-e "s|X2|$$(echo $$VALUES | awk '{print $$2}')|g" \
			-e "s|X3|$$(echo $$VALUES | awk '{print $$3}')|g" overview.svg
