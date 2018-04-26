help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

start:
	docker-compose up -d
	echo "Run 'make logs' to see compose log output"

stop:
	docker-compose stop; \
	docker-compose rm -f

reset:
	docker-compose stop vq_agent_1; \
	docker-compose stop vq_server_1; \
	docker-compose stop vq_etcd0_1; \
        docker-compose rm -f vq_agent_1; \
	docker-compose rm -f vq_server_1; \
	docker-compose rm -f vq_etcd0_1; \
	docker-compose up -d

logs:
	docker-compose logs -f

agent-log:
	docker-compose logs -f agent

server-log:
	docker-compose logs -f server

etcd-log:
	docker-compose logs -f etcd0

clean:
	docker ps -aq | xargs docker rm -f; \
	docker images -aq | xargs docker rmi

.PHONY: help start stop reset logs agent-log server-log etcd-log clean

