FROM golang:1.18-alpine
## We create an /app directory within our
## image that will hold our application source
## files
RUN mkdir /app
## We copy everything in the root directory
## into our /app directory
ADD . /app
# Set working directory
WORKDIR /app
#Copy go mod and sum files
COPY go.mod ./
COPY go.sum ./

RUN curl -L https://pkg.contrastsecurity.com/go-agent-release/latest/linux-amd64/contrast-go > contrast-go
RUN chmod u+x contrast-go
#Run go mod under app directory
RUN go mod download
#Copy all go files
COPY *.go ./

# Run command as described:
# go build will build an executable file named azurepoc in the current directory
RUN contrast-go build -o /godocker
# Run the server executable
CMD [ "/godocker" ]