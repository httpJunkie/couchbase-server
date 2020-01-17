set -m

/entrypoint.sh couchbase-server & 

sleep 15

curl -v -X POST http://127.0.0.1:8091/pools/default -d memoryQuota=512 -d indexMemoryQuota=512 -d ftsMemoryQuota=512

curl -v http://127.0.0.1:8091/node/controller/setupServices -d services=kv%2Cn1ql%2Cindex%2Cfts 

curl -v -u $CB_ADMIN_USER:$CB_ADMIN_PASS -X POST http://127.0.0.1:8091/sampleBuckets/install -d '["travel-sample"]' 

curl -v http://127.0.0.1:8091/settings/web -d port=8091 -d username=$CB_ADMIN_USER -d password=$CB_ADMIN_PASS 

curl -v -u $CB_ADMIN_USER:$CB_ADMIN_PASS -X POST http://127.0.0.1:8091/settings/indexes -d 'storageMode=memory_optimized'

fg 1
