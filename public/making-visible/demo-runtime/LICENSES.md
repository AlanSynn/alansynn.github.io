# Demo artifact licenses and attribution

Static demo build (ADR 006). Every vendored piece is listed with its license
and source. The demo page itself carries the 8285 attribution in the banner.

- Pyodide runtime 314.0.7 (pyodide.mjs, pyodide.asm.mjs, pyodide.asm.wasm,
  python_stdlib.zip, pyodide-lock.json): MPL-2.0 —
  https://github.com/pyodide/pyodide (npm dist, version-pinned).
- sqlalchemy 2.0.48 (pyemscripten wheel): MIT — https://www.sqlalchemy.org
- pydantic 2.12.5 / pydantic-core 2.41.5 (wheels): MIT — https://docs.pydantic.dev
- fastapi 0.136.1 / starlette 1.0.0 (wheels): MIT / BSD-3-Clause —
  https://fastapi.tiangolo.com , https://www.starlette.io
- pydantic-settings 2.15.0 (PyPI wheel, pinned): MIT —
  https://files.pythonhosted.org/packages/30/a4/2bffa9f8e804325a09867f0e9d30795c80ea9f8d62560bd1b6ad6220eb2f/pydantic_settings-2.15.0-py3-none-any.whl
- python-dotenv 1.2.3 (PyPI wheel, pinned): BSD-3-Clause —
  https://files.pythonhosted.org/packages/0d/17/c5c6b53ddc18f297992099b3d9ec16c855c0ccc83263a21fe4d1c625ec6c/python_dotenv-1.2.3-py3-none-any.whl
- Remaining vendored lock wheels (anyio, annotated-doc, annotated-types,
  certifi, h11, httpcore, httpx, idna, jinja2, markupsafe, sniffio,
  typing-extensions, typing-inspection): their own upstream licenses, all
  permissive (MIT / BSD / Apache-2.0 family), fetched from the pinned Pyodide
  CDN release and sha256-verified against the vendored pyodide-lock.json.
- LDraw model "8285-1 Tow Truck" (OMR set 8285) by
  Philippe Hurbain [Philo]: CC-BY-2.0. Verbatim license line in the model
  file: "0 !LICENSE Redistributable under CCAL version 2.0 : see CAreadme.txt".
  Source: https://library.ldraw.org/media/omr_models/1066/8285-1.mpd
  (fixture sidecar: fixtures/ldraw/8285-1.sidecar.json, retrieved 2026-11-02,
  sha256 e43787f23ebcb5e07cf5bea95b9465d4962e1eeaf2b2db4fd953bc121bfa7b81).
- Making Visible service sources (contracts/, packages/, security/,
  services/api/app/, research/study subset, apps/web/demo/demo_shim.py):
  the repository's own license.
