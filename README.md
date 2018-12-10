|Runtime|Version & status|
|---|---|
|dotnet| 2.0 OK |
|python| --coming soon-- |
|node| --coming soon-- |
|powershell| --coming soon-- |

# Vasek's Azure Functions runtime


This repo contains Docker image with enhanced host runtime, based on Microsoft's [Azure Functions host](https://github.com/Azure/azure-functions-host). 

## Why to use this image

Microsoft's Azure Functions host image is dependent on Azure - to run functions on your own server, you need to have Azure Storage instance and have server connected to Azure. 

Main goal of this image is to run Azure Functions without any internet connection on any Docker server you have.

### Important notice

For now, it's not possible to run Azure Functions completely without connection to Azure (Azure Storage) - even with this image.

It's because of runtime host needs to have somewhere metadata about functions (locks, timers) - and Microsoft's host uses Azure Storage internally.

I have idea how to remove this dependency too, but it's a lot of work - will be removed in future.

## How to use

(dotnet) As first you have compile your application by ```microsoft/dotnet``` image.

For runtime use ``` vjirovsky/vaseks-af-host:{runtimelanguage}-{version}```

### Minimum Dockerfile (dotnet):

```docker
FROM microsoft/dotnet:2.1-sdk AS installer-env

COPY src/ /src/
RUN cd /src/SampleFunctionApp && \
    mkdir -p /home/site/wwwroot && \
    dotnet publish *.csproj --output /home/site/wwwroot

FROM vjirovsky/vaseks-af-host:dotnet-2.0

ENV AzureWebJobsStorage="---YOUR-STORAGE_CONNECTION_STRING---"

COPY --from=installer-env ["/home/site/wwwroot", "/home/site/wwwroot"]
```

From Dockerfile you are able to pass on some parameters to your Function application by ENV command (see <i>AzureWebJobsStorage</i> parameter).

### Sample project 

You can find out sample project [here](https://github.com/vjirovsky/docker-vaseks-af-host-sample).

### Result
<img src="https://user-images.githubusercontent.com/2659294/49704046-e3b71100-fc0d-11e8-9c27-c738485f7308.png">
<br /><br />
<img src="https://user-images.githubusercontent.com/2659294/49737517-6632e580-fc8d-11e8-9f0c-81f3c11b3a46.png">