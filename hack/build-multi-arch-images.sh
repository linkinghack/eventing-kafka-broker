docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD;

docker buildx build --platform linux/amd64,linux/arm64 \
  -f ./data-plane/docker/Dockerfile \
  --build-arg JAVA_IMAGE=docker.io/eclipse-temurin:17-jdk-centos7 \
  --build-arg BASE_IMAGE=gcr.io/distroless/java-debian11:base-nonroot \
  --build-arg APP_JAR=receiver-1.0-SNAPSHOT.jar \
  --build-arg APP_DIR=receiver \
  -t "linkinghack/knative-eventing-kafka-broker-receiver:1.2" \
  ./data-plane --push;

docker buildx build --platform linux/amd64,linux/arm64 \
  -f ./data-plane/docker/Dockerfile \
  --build-arg JAVA_IMAGE=docker.io/eclipse-temurin:17-jdk-centos7 \
  --build-arg BASE_IMAGE=gcr.io/distroless/java-debian11:base-nonroot \
  --build-arg APP_JAR=dispatcher-1.0-SNAPSHOT.jar \
  --build-arg APP_DIR=dispatcher \
  -t "linkinghack/knative-eventing-kafka-broker-receiver:1.2" \
  ./data-plane --push
