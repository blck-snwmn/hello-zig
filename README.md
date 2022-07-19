# hello-zig

## Build(WASI)

```bash
zig build-exe src/main.zig -target wasm32-wasi
```

## Run

```bash
zig run src/main.zig
```

If build as 'WASI'

```bash
wasmtime main.wasm
```

## Test

```bash
zig test src/main.zig
```
