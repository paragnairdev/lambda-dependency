FROM microsoft/dotnet:2.1-sdk

COPY src/lambda-dependency/. lambda/
WORKDIR lambda

RUN apt-get update && apt-get install zip -y && dotnet restore && dotnet lambda package