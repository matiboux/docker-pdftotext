# Pdftotext docker image

This repository contains a Docker image that provides the `pdftotext` utility, which is part of the Poppler library.

The `pdftotext` utility converts Portable Document Format (PDF) files to plain text.


## Usage

Run the `pdftotext` image to convert PDF files to text. Interact with the container as you would with the `pdftotext` command-line utility itself. For example, to convert a PDF file to text, you can use the following command:

```bash
docker run --rm -v "$(pwd):/workdir" matiboux/pdftotext input.pdf output.txt
```

The `pdftotext` image is available on:
- The [Docker Hub](https://hub.docker.com/r/matiboux/pdftotext): `docker pull matiboux/pdftotext`, or
- The [GitHub Container Registry](https://github.com/matiboux/pdftotext/pkgs/container/pdftotext): `docker pull ghcr.io/matiboux/pdftotext`


## License

Copyright (c) 2026 [Matiboux](https://github.com/matiboux) ([matiboux.me](https://matiboux.me))

Licensed under the [MIT License](https://opensource.org/license/MIT). You can see a copy in the [LICENSE](LICENSE) file.
