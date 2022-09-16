# io_uring_performance_setup

## Requirements

- Build envoy `bazel build -c opt` or with io_uring `bazel build -c opt //source/exe:envoy_main_common_with_core_extensions_lib`
- Build Nighthawk `i/do_ci.sh build`
- Build Nighthawk server `bazel build -c opt :nighthawk_test_server`

## Benchmark

1. Start Nighthawk test server `taskset -c 0 bazel-bin/nighthawk_test_server --concurrency 1 --config-path ~/Git/io_uring_performance_setup/src/nighthawk-server.yaml` (You must be on Nighthawk's Dir.)
2. Start Envoy server `taskset -c 1 envoy --concurrency 1 --config-path  ~/Git/io_uring_performance_setup/src/envoy-server.yaml --base-id 1`
3. Start the client and measure performance `~/Git/io_uring_performance_setup/aux/measure_perf.sh `


3. (option 2) Start Nighthawk Client `taskset -c 2-3 bazel-bin/nighthawk_client --rps 1000 --connections 4 --concurrency auto --prefetch-connections --duration 10 --latency-response-header-name lat_resp -v info http://127.0.0.1:10000/`  (You must be on Nighthawk's Dir.)

