# Use official Nginx image from Amazon Public ECR to avoid Docker Hub rate limits
FROM public.ecr.aws/nginx/nginx:alpine

# Copy the static HTML file into the container
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
