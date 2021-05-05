# docker-oxipng

Docker image based on Alpine with [oxipng](https://github.com/shssoichiro/oxipng) installed. Usage:

```bash
docker run --rm -v $PWD:/src -w /src ghcr.io/maxx-timing/oxipng \
  oxipng /src/yourfile.png
```
