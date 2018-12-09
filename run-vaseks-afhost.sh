#! /bin/bash

MAX_PROCESS_RESTART=5
COUNTER=1

while [ $COUNTER -lt $(($MAX_PROCESS_RESTART+1)) ]; do
    echo "HOST: Starting application..."
    dotnet /azure-functions-host/Microsoft.Azure.WebJobs.Script.WebHost.dll
    echo "HOST: Application exited with error code: $?"
    echo "HOST: Restarting application (attempt ${COUNTER}/${MAX_PROCESS_RESTART})"
    let COUNTER=COUNTER+1
done

echo "HOST: Application has quit."

exit 1