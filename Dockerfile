# Use the SDK image to build the app
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
 
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["retailstore.csproj", "./"]
RUN dotnet restore "retailstore.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "retailstore.csproj" -c Release -o /app/build
 
FROM build AS publish
RUN dotnet publish "retailstore.csproj" -c Release -o /app/publish
 
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "retailstore.dll"]
