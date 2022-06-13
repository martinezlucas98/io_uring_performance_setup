# io_uring_performance_setup

1. Start Nighthawk test server `taskset -c 0 bazel-bin/nighthawk_test_server --concurrency 1 --config-path ~/Git/io_uring_performance_setup/src/nighthawk-server.yaml` (You must be on Nighthawk's Dir.)
2. Start Envoy server `taskset -c 1 envoy --concurrency 1 --config-path  ~/Git/io_uring_performance_setup/src/envoy-server.yaml --base-id 1`
3. Start perf `perf record --call-graph dwarf -p <ENVOY_PID>`
4. Start Nighthawk Client `taskset -c 2-3 bazel-bin/nighthawk_client --rps 1000 --connections 4 --concurrency auto --prefetch-connections --duration 10 --latency-response-header-name lat_resp -v info http://127.0.0.1:10000/`  (You must be on Nighthawk's Dir.)

