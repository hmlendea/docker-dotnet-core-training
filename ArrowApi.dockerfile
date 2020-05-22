# build                            sudo docker image build -t arrowapi:latest -f ./ArrowApi.dockerfile .
# publish => artifacts
# run => .ddl/.exe                 sudo docker run -p 5000:5000 arrowapi:latest

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app/out .
ENV ASPNETCORE_URLS=http://+:5000
ENTRYPOINT ["dotnet", "ArrowApi.dll"] 
