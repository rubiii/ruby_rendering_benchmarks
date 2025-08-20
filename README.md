# Benchmarking HTML rendering in Ruby  

Here are the contestants:
* [ERB](https://github.com/ruby/erb)
* [Erubi](https://github.com/jeremyevans/erubi)
* [P2](https://github.com/digital-fabric/p2)
* [Papercraft](https://github.com/digital-fabric/papercraft)
* [Phlex](https://github.com/yippee-fun/phlex)
* [ViewComponent](https://github.com/ViewComponent/view_component)

This is my setup:

```
MacBook Pro, 14-inch, Nov. 2024
Apple M4
16 GB memory
macOS 15.6
Ruby 3.4.4
```

These are my results as of August 20, 2025:

![IPS benchmark](docs/ips_20250820.png)

And the memory benchmark:

![Memory benchmark](docs/memory_20250820.png)

And here's how you can run the benchmarks yourself:

```
git checkout git@github.com:rubiii/ruby_rendering_benchmarks.git
cd ruby_rendering_benchmarks
bundle
bin/rails benchmark:ips
bin/rails benchmark:memory
```

If I messed something up, please let me know.
