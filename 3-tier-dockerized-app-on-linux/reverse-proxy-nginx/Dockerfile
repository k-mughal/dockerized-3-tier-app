#  base image
FROM nginx

# Rename the default Nginx configuration file
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled

# Copy my custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Expose the ports
EXPOSE 80

# Command to run Nginx server
CMD ["nginx", "-g", "daemon off;"]
