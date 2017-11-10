FROM ubuntu:17.10

MAINTAINER Boris Penev

ENV ANDROID_HOME="/opt/android-sdk" \
# Get the latest version from https://developer.android.com/studio/index.html
    ANDROID_SDK_TOOLS_VERSION="3859397" \
# Set locale
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    DEBIAN_FRONTEND="noninteractive" \
    ANDROID_SDK_HOME="$ANDROID_HOME" \
    PATH="$PATH:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools" \
    TERM=dumb \
    DEBIAN_FRONTEND=noninteractive


COPY README.md /README.md

WORKDIR /tmp

# Installing packages
RUN apt-get update -qq > /dev/null && \
    apt-get install -qq locales > /dev/null && \
    locale-gen "$LANG" > /dev/null && \
    apt-get install -qq --no-install-recommends \
        build-essential \
        autoconf \
        curl \
        git \
        lib32stdc++6 \
        lib32z1 \
        lib32z1-dev \
        lib32ncurses5 \
        libc6-dev \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev \
        libxslt-dev \
        libxml2-dev \
        m4 \
        ncurses-dev \
        ocaml \
        openjdk-8-jdk \
        openssh-client \
        pkg-config \
        python-software-properties \
        software-properties-common \
        unzip \
        wget \
        zip \
        zlib1g-dev > /dev/null && \
    apt-get clean > /dev/null && \
    rm -rf /var/lib/apt/lists/ && \
    rm -rf /tmp/* /var/tmp/*

# Install Android SDK
RUN echo "installing sdk tools" && \
    wget --quiet --output-document=sdk-tools.zip \
        "https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip" && \
    mkdir --parents "$ANDROID_HOME" && \
    unzip -q sdk-tools.zip -d "$ANDROID_HOME" && \
    rm --force sdk-tools.zip && \
# Install SDKs
# The `yes` is for accepting all non-standard tool licenses.
    mkdir --parents "$HOME/.android/" && \
    echo '### User Sources for Android SDK Manager' > \
        "$HOME/.android/repositories.cfg" && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager --licenses > /dev/null && \
    echo "installing android packages" && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager \
        "platform-tools" \
        "platforms;android-26" \
        "build-tools;26.0.3" \
        "extras;android;m2repository" \
        "extras;google;m2repository" \

