FROM ruby:2.7-alpine as builder
LABEL MAINTAINER="Marco Bergantin <marco@bergant.in>"

RUN apk add --update build-base libffi-dev sqlite-dev nodejs

COPY Gemfile /usr/local/src/
COPY *.gemspec /usr/local/src/
COPY lib/mail_catcher/version.rb /usr/local/src/lib/mail_catcher/version.rb

WORKDIR /usr/local/src

RUN bundle install

COPY ./ /usr/local/src

RUN bundle exec rake package


FROM ruby:2.7-alpine
LABEL MAINTAINER="Marco Bergantin <marco@bergant.in>"

ARG VERSION=0.8.0.beta2
ARG GEM_DEPS="build-base sqlite-dev"
ARG RUBY_DEPS="sqlite-libs"

WORKDIR /usr/local/src

RUN apk add --update --no-cache $GEM_DEPS --virtual .gemdeps

COPY --from=builder /usr/local/src/mailcatcher-${VERSION}.gem ./

RUN gem install mailcatcher-${VERSION}.gem && \
  rm mailcatcher-${VERSION}.gem && \
  apk del .gemdeps

EXPOSE 1025 1080

ENTRYPOINT ["mailcatcher", "--foreground"]
CMD ["--ip", "0.0.0.0"]
