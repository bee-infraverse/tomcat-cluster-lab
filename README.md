# Tomcat Cluster Lab

Kubernetes lab environment for exploring Apache Tomcat session clustering using sticky sessions, in-memory replication, and shared storage backends. Ideal for learning, testing, and demonstrating high availability setups in containerized environments.

## Simplifying Apache Tomcat Session Clustering with Kubernetes

Motivation is present this at JAX 2025 Mainz

Title: Simplifying Apache Tomcat Session Clustering with Kubernetes

Abstract:

Building resilient applications on Kubernetes often means managing user sessions across multiple nodes in a Tomcat cluster. Traditionally, configuring Tomcat clustering required manually adjusting XML files to ensure session persistence and redundancy. But in modern, cloud-native environments, this approach is no longer sufficient or scalable.

In this talk, I will dive into how Apache Tomcat supports session clustering in Kubernetes, simplifying the process and providing two powerful clustering methods: KubernetesMembershipProvider and DNSMembershipProvider. These solutions help distribute sessions across Tomcat nodes effectively, ensuring high availability and fault tolerance with minimal manual configuration.

Join us to learn how to streamline Tomcat session clustering in Kubernetes, enhance your infrastructure's scalability, and make your applications more resilient. Whether you're transitioning from a legacy system or building a new cloud-native application, this session will provide valuable insights for both.

Who Should Attend:

* DevOps engineers and system architects transitioning to Kubernetes.
* Developers and SREs maintaining Java applications on Tomcat.
* Cloud-native enthusiasts interested in resilient session management.

Shorter

Explore how to streamline session clustering in Apache Tomcat with Kubernetes, transitioning from traditional manually configuration to modern, Kubernetes-native methods. Learn how Tomcat's Session Clustering enable efficient, automated session management across multiple nodes, enhancing scalability and fault tolerance. This session will cover practical steps to configure and maintain high availability in cloud-native environments, making it ideal for DevOps engineers, architects, and developers managing Java applications on Kubernetes.

- [K8s-meets-Tomcat-Cluster-PeterRossbach-JAX2025-05](./presentation/K8s-meets-Tomcat-Cluster-PeterRossbach-JAX2025-05.md)

## Design of statefull applications 

In today's fast-paced world of cloud-native applications, microservices, and serverless functions dominate the headlines. Stateless architecture is the gold standard—modern software components no longer store session data at the middleware level. The principles outlined in [The Twelve-Factor App](https://12factor.net) provide a proven framework for building scalable, maintainable, and resilient applications. Embracing these best practices will set your applications up for success—so make sure to follow them!

But let’s not forget: Java has a 30-year legacy, and countless applications are still running, built on battle-tested server-side rendering frameworks. These applications, designed for stateful middleware, continue to power critical business logic at scale. And for good reason! Managing state server-side gives developers full control over the client experience, ensuring security, consistency, and centralized session handling.

Frameworks like [Apache Wicket](https://wicket.apache.org), [Struts](https://struts.apache.org), [Native JSP](https://jakarta.ee/specifications/pages/3.0/jakarta-server-pages-spec-3.0), [Spring MVC](https://docs.spring.io/spring-framework/reference/web/webmvc.html), [Vaadin](https://vaadin.com) and [GWT](https://www.gwtproject.org/overview.html) are not relics of the past—they are still heavily used and serve millions of users daily. Understanding and maintaining these systems is just as important as embracing the latest trends. After all, the best engineers are those who can bridge the gap between innovation and existing infrastructure. 🚀

- https://en.wikipedia.org/wiki/Design_by_contract
- [History of Tomcat](History%20of%20Tomcat.md)

## Tomcat Session Replication

### The Evolution of Stateful Java Applications with Tomcat

In the early 2000s, the world of Java applications was thriving, but scalability and reliability were constant challenges. By 2003, Apache Tomcat had already established itself as a leading lightweight Java servlet container. However, as businesses demanded more robust, stateful applications, Tomcat had to evolve beyond simple request handling—it needed to support seamless session replication for high availability.

### The Rise of Stateful Java Applications

Back then, stateful web applications were the norm. Java frameworks like Struts, JSP, Spring MVC, and Apache Wicket gained massive adoption, all relying on server-side session storage. Enterprises needed their applications to maintain user sessions across multiple servers for seamless failover and scaling. Tomcat answered the call with session persistence and replication strategies, setting the foundation for modern web session management.

### Effortless Load Dispatching with Apache and AJP

A key factor in Tomcat's widespread success was its ability to integrate elegantly with Apache HTTP Server using the [Apache JServ Protocol (AJP)](https://tomcat.apache.org/connectors-doc/ajp/ajpv13a.html?utm_source=chatgpt.com). This setup allowed Tomcat to sit behind a powerful Apache front-end, efficiently dispatching requests while offloading static content. Load balancing was made easy with the mod_jk and later mod_proxy modules, which provided failover support, session stickiness, and advanced routing capabilities—all critical for running stateful applications in production.

Apache Tomcat Connector Modules:

- [mod_jk](https://tomcat.apache.org/connectors-doc/)  
  A connector module for integrating Tomcat with Apache HTTP Server using the AJP protocol.
- [mod_proxy](https://httpd.apache.org/docs/current/mod/mod_proxy.html)  
  Generic proxy module that supports forwarding HTTP, HTTPS, and other protocols.
- [mod_proxy_ajp](https://httpd.apache.org/docs/current/mod/mod_proxy_ajp.html)  
  A proxy module that enables Apache HTTPD to communicate with Tomcat using the AJP protocol.
- [mod_ajp (Tomcat AJP Connector)](https://tomcat.apache.org/tomcat-9.0-doc/config/ajp.html)  
  Tomcat’s built-in AJP connector for use with reverse proxies like Apache HTTPD or load balancers.
- [mod_proxy_balancer](https://httpd.apache.org/docs/current/mod/mod_proxy_balancer.html)  
  Used to set up load balancing with `mod_proxy`, supporting sticky sessions and failover.
- [mod_cluster](https://modcluster.io/)  
  A more advanced, dynamic load-balancing module for Apache HTTPD, often used with JBoss/WildFly and Tomcat.

### The Backbone: Tomcat’s Memory Replication Bus

To support large-scale deployments, Tomcat introduced a Memory Replication Bus, enabling session data to be shared across multiple nodes. This allowed applications to gracefully handle server failures without losing user sessions. Over time, Tomcat offered various session persistence mechanisms:

- File-based persistence using FileStore, writing session data to a shared filesystem.
- Database-backed persistence using JDBCStore, allowing centralized session management via a relational database.
- In-memory replication with SimpleTcpCluster, providing near-instantaneous session syncing across multiple Tomcat instances.

Alternative Session Store options:

- Redis or Memcached Session Backend
- Hazelcast Session in memory cache
- JGroups Session in memory cache (JBoss)

### The Evolution of SimpleTcpCluster

Tomcat's SimpleTcpCluster implementation evolved to support different networking models for replicating session data across distributed environments:

* Static Members: Manually configured nodes for on-premise clusters.
* Multicast: Automatically discovering and syncing nodes within a local network.
* Cloud-Native Integrations: As cloud computing gained traction, Tomcat adapted to dynamic environments:
  * DNS-based discovery, allowing instances to register and locate each other dynamically.
  * Kubernetes Pods, enabling session replication within containerized deployments, ensuring seamless failover in microservices-driven architectures.

### Tomcat’s Legacy in the Cloud Era

Despite the industry’s shift toward stateless microservices and serverless architectures, stateful Java applications continue to play a vital role in enterprises. Many legacy systems still rely on Tomcat’s session replication, load balancing, and failover capabilities to keep business-critical applications running smoothly. Even today, Tomcat remains a top choice for organizations bridging the gap between traditional and cloud-native application architectures.

From AJP-based load balancing to Kubernetes-powered clustering, Tomcat’s journey has been one of adaptability and resilience. Its innovations in session replication and high availability have shaped the way Java applications are built and scaled, proving that even in a world of microservices, stateful applications still have a place.

- Using session persistence and saving the session to a shared file system (e.g. FileStore) or shared database (e.g. JDBCStore).
- Using in-memory replication via the SimpleTcpCluster implementation included with Tomcat.
  - Static Member
  - Multicast
  - Cloud
    - DNS
    - Kubernetes Pods...

Session Repl

- https://github.com/devlinx9/k8s_tomcat_custer
  - Check error wtih cluster admin
  - Create static or dynamic token
  - Names of the properties...

## Alternative projects and other infos

- https://redisson.org/glossary/tomcat-web-session-replication.html
  - https://github.com/redisson/redisson/wiki/2.-Configuration
- Hazelcast ( Spring Boot)
- https://www.google.com/search?q=Tomcat:+From+a+Cluster+to+a+Cloud+slides&client=safari&sca_esv=8569cf8a79d87c05&hl=de-de&udm=2&sa=X&ved=2ahUKEwjW6dzeptKJAxVrGRAIHRCXBQEQ7Al6BAgaEAQ&biw=390&bih=745&dpr=3
- https://www.slideshare.net/slideshow/from-a-cluster-to-the-cloud/173580447
- https://github.com/jfclere/tomcat-kubernetes/
  - https://youtu.be/COsTWphp2fk?si=RnOaJ6gJqdlptjOC
- https://cwiki.apache.org/confluence/plugins/servlet/mobile?contentId=103098633#content/view/103098633
- https://github.com/jfclere/tomcat-kubernetes
- https://tomcat.apache.org/presentations/2020-09-29-achome-Lost-in-the-docs.pdf
- https://github.com/devlinx9/k8s_tomcat_custer
- https://tomcat.apache.org/tomcat-9.0-doc/cluster-howto.html
- https://jogetdoc.int.joget.cloud/jw/web/userview/jdocs/docs/DX8/joget-clustering-using-tomcat-session-replication
- https://github.com/hazelcast/hazelcast-tomcat-sessionmanager
- https://vaadin.com/docs/latest//tools/kubernetes/session-replication
- https://hazelcast.com/blog/spring-boot-tomcat-session-replication-on-kubernetes-using-hazelcast/
- https://medium.com/@armyost1/how-to-set-up-tomcat-clustering-in-k8s-and-how-does-it-work-3103e0d12ef9
- MemberShip Module SourceCode :
https://github.com/apache/tomcat/blob/main/java/org/apache/catalina/tribes/membership/cloud

Reduce Image

- https://blog.monosoul.dev/2022/04/25/reduce-java-docker-image-size/ 

## Examples

- [Basic Traefik](./examples/traefik/README.md)  
  - Simple Tomcat Setup with HTTP Proxy Traefik
  - Setup stdout access Log

- [Cluster test](./examples/clustertest/README.md)  
  - Test Session Replication
  - use war file as separate container

- [Proxy-Based Session Routing](./examples/httpd2tomcat/README.md)  
  - `mod_jk` to forward requests to Tomcat nodes.
  - Java Agent integrations
  - Add Otel auto instrumentation for tracing
  - Prometheus and Jaeger
  - Access log to stdout
  - Use docker compose
  - Create mod_jk prometheus exporter🚀

- [Tomcat Cluster meets K8s](./examples/k8s-tomcat-cluster/README.md)  
  - Use a Kubernetes Stateful set 
  - Java Agent integrations
  - Use Traefik ingress Proxy for loadbalacing

## Add more later

- Kubernetes Tomcat Operator example
- Kubernetes Test cluster setup and github action
- iximiuz lab tutorial
- Fix License issues
- Access War Files with Kubernetes ImageVolumes

Regards,

`├─☺︎─┤` The humble paint signer: <peter.rossbach@bee42.com>  copyright 2025 - bee42 solutions gmbh 