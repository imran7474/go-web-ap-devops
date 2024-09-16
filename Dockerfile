# Use an official Go runtime as a parent image
FROM golang:1.23-alpine AS builder

# Set the current working directory inside the container
WORKDIR /app

# Copy go mod and go sum files
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go web app
RUN go build -o main .

# Use a minimal base image for the final container
FROM alpine:latest
WORKDIR /app

# Copy the built Go binary and the HTML, CSS files from the builder stage
COPY --from=builder /app/main .
COPY --from=builder /app/templates ./templates
COPY --from=builder /app/static ./static

# Expose port 8080 to the outside world
EXPOSE 8080

# Run the web app
CMD ["./main"]
