# Use official Nginx image as base
FROM nginx:alpine

# Copy the static HTML file into the container
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
