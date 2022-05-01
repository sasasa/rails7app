FROM ruby:3.1.2
RUN apt-get update -qq \
  && apt-get install -y nodejs npm \
  && rm -rf /var/lib/apt/lists/* \
  && npm install --global yarn

ENV APP_NAME=myapp
ENV TZ=Asia/Tokyo
ENV BUNDLER_VERSION=2.3.10

WORKDIR /${APP_NAME}

COPY Gemfile /${APP_NAME}/Gemfile
COPY Gemfile.lock  /${APP_NAME}/Gemfile.lock
RUN gem update --system && \
    gem update bundler && \
    bundle install
# Bundlerをアップデートできれば良いので
# gem install bundler -v ${BUNDLER_VERSION}は以下のどちらかでも対応可能です。

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#RUN adduser ${USER_NAME} && \
#    chown -R ${USER_NAME} /${APP_NAME}
#USER ${USER_NAME}

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]