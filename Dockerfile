FROM golang:1.21.6-alpine AS build

WORKDIR /app

COPY . .

RUN go mod download
RUN go build -o main .

FROM alpine:latest as release
EXPOSE 8000
COPY --from=build /app/main /server
ENTRYPOINT ["/server"]
CMD ["-port", "8000"]
