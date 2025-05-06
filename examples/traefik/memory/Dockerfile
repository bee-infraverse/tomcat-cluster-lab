FROM eclipse-temurin:21-jdk-alpine

COPY *.java /src/

RUN mkdir /app \
    && ls /src \
    && javac /src/PrintXmxXms.java -d /app

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"
ENV JAVA_OPTS=""

CMD ["sh", "-c", \
     "java -version \
      && java $JAVA_OPTS -cp /app PrintXmxXms"]
