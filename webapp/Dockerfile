FROM golang:1.22.3-bookworm AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN go build -o /webapp .

FROM gcr.io/distroless/base-debian12

COPY --from=build /webapp /webapp

ENTRYPOINT ["/webapp"]
