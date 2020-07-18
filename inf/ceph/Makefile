cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

download:
	curl -L https://github.com/ceph/cn/releases/download/v2.3.1/cn-v2.3.1-linux-amd64 -o $(CN) && chmod +x $(CN)

run:
	for cluster in $(CLUSTERS);	do \
		mkdir -p /tmp/$$cluster; \
		./$(CN) cluster start -d /tmp/$$cluster $$cluster; \
		docker exec -ti ceph-nano-$$cluster radosgw-admin user create --uid=admin --display-name=admin; \
		docker exec -ti ceph-nano-$$cluster radosgw-admin key create --uid=admin --key-type=s3 --access-key access --secret-key secret; \
	done

stop:
	for cluster in $(CLUSTERS);	do
		./$(CN) cluster stop $$cluster; \
	done

remove:
	for cluster in $(CLUSTERS); do \
		./$(CN) cluster purge $$cluster --yes-i-am-sure; \
	done
