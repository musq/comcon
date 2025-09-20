# Generate a random instance id on each boot of the container

INSTANCE_ID="$(date +"%Y%m%d_%H%M%S")_$(cat /dev/urandom | tr -dc A-Z0-9 | head -c4)"

export INSTANCE_ID
export OTEL_RESOURCE_ATTRIBUTES="service.instance.id=$INSTANCE_ID"

# TODO: Remove experimental flag once otelcol.processor.deltatocumulative becomes GA
/bin/alloy run --server.http.listen-addr=0.0.0.0:12345 \
  --storage.path=/var/lib/alloy/data \
  --stability.level=experimental \
  /etc/alloy/config.alloy
