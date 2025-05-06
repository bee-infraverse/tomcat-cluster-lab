# mod_jk prometheus adapter

```shell
docker build -t mod_jk .
docker run \
  --net container:httpd2tomcat-httpd-1 \
  -d --name mod_jk mod_jk
docker exec -it mod_jk /bin/bash
apt update && apt install -y curl
curl 127.0.0.1:5000/metrics
# HELP python_gc_objects_collected_total Objects collected during gc
# TYPE python_gc_objects_collected_total counter
python_gc_objects_collected_total{generation="0"} 400.0
python_gc_objects_collected_total{generation="1"} 0.0
python_gc_objects_collected_total{generation="2"} 0.0
# HELP python_gc_objects_uncollectable_total Uncollectable object found during GC
# TYPE python_gc_objects_uncollectable_total counter
python_gc_objects_uncollectable_total{generation="0"} 0.0
python_gc_objects_uncollectable_total{generation="1"} 0.0
python_gc_objects_uncollectable_total{generation="2"} 0.0
# HELP python_gc_collections_total Number of times this generation was collected
# TYPE python_gc_collections_total counter
python_gc_collections_total{generation="0"} 68.0
python_gc_collections_total{generation="1"} 6.0
python_gc_collections_total{generation="2"} 0.0
# HELP python_info Python platform information
# TYPE python_info gauge
python_info{implementation="CPython",major="3",minor="12",patchlevel="10",version="3.12.10"} 1.0
# HELP process_virtual_memory_bytes Virtual memory size in bytes.
# TYPE process_virtual_memory_bytes gauge
process_virtual_memory_bytes 1.25820928e+08
# HELP process_resident_memory_bytes Resident memory size in bytes.
# TYPE process_resident_memory_bytes gauge
process_resident_memory_bytes 4.1590784e+07
# HELP process_start_time_seconds Start time of the process since unix epoch in seconds.
# TYPE process_start_time_seconds gauge
process_start_time_seconds 1.74602051509e+09
# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 0.36000000000000004
# HELP process_open_fds Number of open file descriptors.
# TYPE process_open_fds gauge
process_open_fds 7.0
# HELP process_max_fds Maximum number of open file descriptors.
# TYPE process_max_fds gauge
process_max_fds 1.048576e+06
# HELP modjk_ajp_used Number of used connections
# TYPE modjk_ajp_used gauge
modjk_ajp_used 0.0
# HELP modjk_ajp_errors Number of error connections
# TYPE modjk_ajp_errors gauge
modjk_ajp_errors 0.0
# HELP modjk_ajp_client_errors Client error count
# TYPE modjk_ajp_client_errors gauge
modjk_ajp_client_errors 0.0
# HELP modjk_ajp_reply_timeouts Reply timeouts
# TYPE modjk_ajp_reply_timeouts gauge
modjk_ajp_reply_timeouts 0.0
# HELP modjk_ajp_transferred Bytes transferred
# TYPE modjk_ajp_transferred gauge
modjk_ajp_transferred 0.0
# HELP modjk_ajp_read Bytes read
# TYPE modjk_ajp_read gauge
modjk_ajp_read 0.0
# HELP modjk_ajp_busy Busy connections
# TYPE modjk_ajp_busy gauge
modjk_ajp_busy 0.0
# HELP modjk_ajp_max_busy Max busy connections
# TYPE modjk_ajp_max_busy gauge
modjk_ajp_max_busy 0.0
# HELP modjk_ajp_connected Currently connected
# TYPE modjk_ajp_connected gauge
modjk_ajp_connected 0.0
# HELP modjk_ajp_max_connected Max ever connected
# TYPE modjk_ajp_max_connected gauge
modjk_ajp_max_connected 0.0
```

prometheus.yaml

```yaml
- job_name: 'apache-modjk'
  static_configs:
    - targets: ['host.docker.internal:9114']  # If Prometheus runs in Docker on Mac/Windows
```
