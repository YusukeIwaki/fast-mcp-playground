FROM ruby:3.4-alpine

# Install dependencies
RUN apk add --no-cache \
    build-base \
    sqlite-dev \
    tzdata \
    curl \
    bash

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock /app/

# Install the gems
RUN bundle install

# Copy the rest of the application code
COPY --chmod=755 entrypoint.sh /app/entrypoint.sh
COPY . /app/
RUN rm -f /app/storage/*.sqlite3

# Expose the port the app runs on
EXPOSE 3000

ENTRYPOINT [ "/app/entrypoint.sh" ]

# Start the application
CMD ["bundle", "exec", "ruby", "app.rb"]
