# Use the Rocker project’s Shiny base image
FROM rocker/shiny:4.5.1

# Install system dependencies
RUN apt update
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libxml2
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libssl-dev
RUN rm -rf /var/lib/apt/lists/*

# Copy your app to the container
COPY ./ /srv/shiny-server/

# Move custom config into place
RUN mv /srv/shiny-server/shiny-server.conf /etc/shiny-server/shiny-server.conf

# Set permissions
RUN chown -R shiny:shiny /srv/shiny-server

# Install R package dependencies
RUN R -e "install.packages('shiny',          dependencies=TRUE, repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('shinydashboard', dependencies=TRUE, repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('shinyjs',        dependencies=TRUE, repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('V8',             dependencies=TRUE, repos='https://cloud.r-project.org/')"

# Expose the Shiny port
EXPOSE 3838

# Run the Shiny app
CMD ["/usr/bin/shiny-server"]
