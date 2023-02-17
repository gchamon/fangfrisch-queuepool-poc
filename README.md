Working proof of concept of the issue with QueuePool when using fangfrisch

# Build

```bash
docker build --tag fangfrisch-queuepool-poc .
```

# Usage

```bash
docker run -it --rm fangfrisch-queuepool-poc refresh
```

Should result in the following error output:

```
Traceback (most recent call last):
  File "/var/lib/fangfrisch/venv/bin/fangfrisch", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/fangfrisch/__main__.py", line 64, in main
    ClamavRefresh(args).refresh_all()
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/fangfrisch/refresh.py", line 142, in refresh_all
    if self.refresh(ci):
       ^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/fangfrisch/refresh.py", line 118, in refresh
    if digest.data and RefreshLog.digest_matches(ci.url, digest.data):
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/fangfrisch/db.py", line 156, in digest_matches
    entry: RefreshLog = _query_url(url, RefreshLog._session())
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/fangfrisch/db.py", line 239, in _query_url
    return session.query(RefreshLog).filter(RefreshLog.url == url).first()
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/orm/query.py", line 2752, in first
    return self.limit(1)._iter().first()  # type: ignore
           ^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/orm/query.py", line 2855, in _iter
    result: Union[ScalarResult[_T], Result[_T]] = self.session.execute(
                                                  ^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/orm/session.py", line 2229, in execute
    return self._execute_internal(
           ^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/orm/session.py", line 2114, in _execute_internal
    conn = self._connection_for_bind(bind)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/orm/session.py", line 1981, in _connection_for_bind
    return trans._connection_for_bind(engine, execution_options)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<string>", line 2, in _connection_for_bind
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/orm/state_changes.py", line 137, in _go
    ret_value = fn(self, *arg, **kw)
                ^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/orm/session.py", line 1108, in _connection_for_bind
    conn = bind.connect()
           ^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/engine/base.py", line 3245, in connect
    return self._connection_cls(self)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/engine/base.py", line 145, in __init__
    self._dbapi_connection = engine.raw_connection()
                             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/engine/base.py", line 3269, in raw_connection
    return self.pool.connect()
           ^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/pool/base.py", line 455, in connect
    return _ConnectionFairy._checkout(self)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/pool/base.py", line 1270, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/pool/base.py", line 719, in checkout
    rec = pool._do_get()
          ^^^^^^^^^^^^^^
  File "/var/lib/fangfrisch/venv/lib/python3.11/site-packages/sqlalchemy/pool/impl.py", line 157, in _do_get
    raise exc.TimeoutError(
sqlalchemy.exc.TimeoutError: QueuePool limit of size 5 overflow 10 reached, connection timed out, timeout 30.00 (Background on this error at: https://sqlalche.me/e/20/3o7r)
```

# Getting the modules list

```bash
docker run -it --rm --entrypoint="" fangfrisch-queuepool-poc bash -c 'source venv/bin/activate && pip freeze'
```

Which should result as of today (2023-02-17) in:

```
certifi==2022.12.7
charset-normalizer==3.0.1
fangfrisch==1.5.0
greenlet==2.0.2
idna==3.4
requests==2.28.2
SQLAlchemy==2.0.3
typing_extensions==4.5.0
urllib3==1.26.14
```

