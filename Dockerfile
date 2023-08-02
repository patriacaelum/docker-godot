# Base Image
FROM archlinux:latest

# Maintainer info
MAINTAINER patriacaelum <austin@moroses.ca>

# Custom parameters
ENV GODOT_RELEASE=stable
ENV GODOT_VERSION=4.1
ENV TERM=xterm-256color

# Directories
ENV DIR_GODOT_EXPORT_TEMPLATES=~/.local/share/godot/export_templates/${GODOT_VERSION}.${GODOT_RELEASE}

# Local Godot files
ENV GODOT_ROOT=Godot_v${GODOT_VERSION}-${GODOT_RELEASE}
ENV GODOT=${GODOT_ROOT}_linux.x86_64
ENV GODOT_EXPORT_TEMPLATES_ZIP=${GODOT_ROOT}_export_templates.tpz
ENV GODOT_ZIP=${GODOT}.zip

# Godot URLs
ENV GODOT_URL_ROOT=https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}
ENV GODOT_URL=${GODOT_URL_ROOT}/${GODOT_ZIP}
ENV GODOT_URL_EXPORT_TEMPLATES=${GODOT_URL_ROOT}/${GODOT_EXPORT_TEMPLATES_ZIP}

# Update and install dependencies
RUN pacman -Syu --noconfirm \
	&& pacman -S --noconfirm make p7zip \
	&& curl ${GODOT_URL} --output ${GODOT_ZIP} \
	&& curl ${GODOT_URL_EXPORT_TEMPLATES} --output ${GODOT_EXPORT_TEMPLATES_ZIP} \
	&& 7z x ${GODOT_ZIP} \
	&& 7z x ${GODOT_EXPORT_TEMPLATES_ZIP} \
	&& mv ${GODOT} ~/ \
	&& mkdir -p ${DIR_GODOT_EXPORT_TEMPLATES} \
	&& cp templates/* ${DIR_GODOT_EXPORT_TEMPLATES} \
	&& rm -f ${GODOT_ZIP} \
	&& rm -f ${GODOT_EXPORT_TEMPLATES_ZIP} \
	&& rm -rf templates/ \

