# Purpur Server 1.19.3

FROM alpine:latest

# Default env variables
#ENV PORT 25565
ENV MAXMEN -Xmx4096M
ENV MINMEM -Xms100M

# Ports
EXPOSE 25565
EXPOSE 25565/tcp
EXPOSE 25565/udp

# Required packages for both steamcmd and cs1.6 server
RUN apk update
RUN apk add openjdk17-jre-headless wget libstdc++

# Download PurpurMC
RUN mkdir /mc-server
WORKDIR /mc-server
RUN echo "eula=True" > eula.txt
RUN wget -nv https://api.purpurmc.org/v2/purpur/1.19.3/latest/download
RUN mv download purpur.jar
RUN chmod +x purpur.jar

# Start server
CMD java $MINMEM $MAXMEM -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true --add-modules=jdk.incubator.vector -jar purpur.jar --nogui
#CMD java -jar purpur.jar

