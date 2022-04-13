# --- BUILD ---
FROM alpine AS build

ENV CGO_ENABLED=1

RUN apk --no-cache add go g++ gcc

RUN go install -tags whatsappmulti github.com/42wim/matterbridge@master

# --- RUNTIME ---
FROM alpine as runtime

RUN apk --no-cache add ca-certificates mailcap libstdc++

COPY --from=build /root/go/bin/matterbridge /bin/matterbridge

WORKDIR /etc/matterbridge

ENTRYPOINT ["/bin/matterbridge", "-conf", "/etc/matterbridge/matterbridge.toml"]
