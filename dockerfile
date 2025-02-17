# Use the official Ruby image
FROM ruby:3.2.2

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock (for caching gem installation)
COPY Gemfile Gemfile.lock ./
COPY config.ru ./config.ru
COPY lib/ ./lib/
COPY public/ ./public/
# Install gems
RUN bundle install --jobs 4 --retry 3

# Copy the rest of the application code
COPY . .

# Expose the port for the Rack application
EXPOSE 9292

# Command to run the Rack app
CMD ["rackup", "-o", "0.0.0.0", "-p", "9292"]
