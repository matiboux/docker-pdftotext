#syntax=docker/dockerfile:1

# This Dockerfile uses the service folder as context.


# --
# Upstream images

FROM alpine:3.22 AS alpine_upstream


# --
# Build image

FROM alpine_upstream AS app_build

ARG POPPLER_VERSION=26.06.0
ARG POPPLER_URL=https://poppler.freedesktop.org/poppler-${POPPLER_VERSION}.tar.xz

# Download and extract poppler source code
WORKDIR /tmp
RUN wget -q ${POPPLER_URL} -O poppler.tar.xz && \
	tar -xf poppler.tar.xz && \
	rm poppler.tar.xz

# Install build dependencies
RUN apk add --no-cache \
	build-base \
	cmake \
	fontconfig-dev \
	freetype-dev \
	libstdc++ \
	libjpeg-turbo-dev \
	ninja

# Build pdftotext utility
WORKDIR /tmp/poppler-${POPPLER_VERSION}
RUN cmake -S . -B build -G Ninja \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_CPP_TESTS=OFF \
	-DBUILD_GTK_TESTS=OFF \
	-DBUILD_MANUAL_TESTS=OFF \
	-DBUILD_QT5_TESTS=OFF \
	-DBUILD_QT6_TESTS=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DBUILD_UTILS=ON \
	-DENABLE_BOOST=OFF \
	-DENABLE_CAIRO=OFF \
	-DENABLE_CPP=OFF \
	-DENABLE_GLIB=OFF \
	-DENABLE_GOBJECT_INTROSPECTION=OFF \
	-DENABLE_GPGME=OFF \
	-DENABLE_GPGME=OFF \
	-DENABLE_LCMS=OFF \
	-DENABLE_LIBCURL=OFF \
	-DENABLE_LIBOPENJPEG=none \
	-DENABLE_LIBTIFF=OFF \
	-DENABLE_NSS3=OFF \
	-DENABLE_QT5=OFF \
	-DENABLE_QT6=OFF \
	-DENABLE_UNSTABLE_API_ABI_HEADERS=OFF
RUN cmake --build build --target pdftotext --config Release
RUN cp ./build/utils/pdftotext /usr/local/bin/
RUN pdftotext -v


# --
# Prod image

FROM alpine_upstream AS app_prod

# Install runtime dependencies
RUN apk add --no-cache \
	fontconfig \
	freetype \
	libjpeg-turbo \
	libstdc++

# Copy pdftotext utility from build image
COPY --from=app_build /usr/local/bin/pdftotext /usr/local/bin/

ENTRYPOINT [ "pdftotext" ]
CMD [ "--help" ]
