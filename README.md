# memcache: Haskell Memcache Client

This library provides a client interface to a Memcache cluster. It is
aimed at full binary protocol support, ease of use and speed.

## Licensing

This library is BSD-licensed.

## Tools

This library also includes a few tools for manipulating and
experimenting with memcached servers.

* `OpGen` -- A load generator for memcached. Doesn't collect timing
  statistics, other tools like
  [mutilate](https://github.com/leverich/mutilate) already do that
  very well. This tool is useful in conjunction with mutilate.
* `Loader` -- A tool to load random data of a certain size into a
  memcache server. Useful for priming a server for testing.

## Architecture Notes

We're relying on `Data.Pool` for thread safety right now, which is
fine but is a blocking API in that when we grab a socket
(`withResource`) we are blocking any other requests being sent over
that connection until we get a response. That is, we can't pipeline.

Now, use of multiple connections through the pool abstraction is an
easy way to solve this and perhaps the right approach. But, could also
implement own pool abstraction that allowed pipelining. This wouldn't
be a pool abstraction so much as just round-robbining over multiple
connections for performance.

Either way, a pool is fine for now.

## ToDo

Required:
* Multiple-server support -- mod & consistent hashing
* Connection error handling
* SASL
* Timeouts

Optional:
* Multi-get
* Generic multi operation support

Nice-to-have:
* Asynchronous support
* Customizable -- timeout, max connection retries, hash algorithm
* Max value validation
* Optimizations --  http://code.google.com/p/spymemcached/wiki/Optimizations
* UDP
* ASCII
* Server error handling mode where we return misses and ignore sets

Maybe:
* Typeclass for serialization
* Monad / Typeclass for memcache

## Other clients

* [C: libmemcached](http://libmemcached.org/libMemcached.html)
* [Java: SpyMemcached](http://code.google.com/p/spymemcached/)
* [Ruby: Dalli](https://github.com/mperham/dalli)

## Get involved!

We are happy to receive bug reports, fixes, documentation enhancements,
and other improvements.

Please report bugs via the
[github issue tracker](http://github.com/dterei/mc-hs/issues).

Master [git repository](http://github.com/dterei/mc-hs):

* `git clone git://github.com/dterei/mc-hs.git`

## Authors

This library is written and maintained by David Terei,
<code@davidterei.com>.

