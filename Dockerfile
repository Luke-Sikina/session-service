#
# Copyright (c) 2019 The Hyve B.V.
# This code is licensed under the GNU Affero General Public License (AGPL),
# version 3, or (at your option) any later version.
#

FROM maven:3.6 as build
COPY $PWD /session-service
WORKDIR /session-service
RUN mvn package -DskipTests -Dpackaging.type=jar

FROM openjdk:8-jre
COPY --from=build /session-service/target/*.jar /app.war
CMD /usr/bin/java ${JAVA_OPTS} -jar /app.war