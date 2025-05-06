# The History of Apache Tomcat – A Complete Timeline

## 1995: Jetty Contest and the Servlet Spark

The idea for a web server that could serve Java came from internal contests and explorations, including alternatives like Jetty.
The focus was on embedding Java in web servers, paving the way for servlet containers.

## 1996–1997: Jeeves and the Early Servlet Container

James Duncan Davidson, an engineer at Sun Microsystems, started developing a servlet container engine Tomcat, 
internally used at Sun to support the early Java Servlet API. This was possible after internal reorg to integrate the JavaSoft Java HTTP Server Jeeves.

- Java Servlet Development Kit (JSDK) 1.0
- JavaServer Web Development Kit (JWSDK) for the Servlet 2.0 specification

## 1998/99: My Jo! and Early Servlet Books

- Java Servlet Programming by Jason Hunter with William Crawford, OReilly(Oct 1998)
- Around this time, Apache JServ, another early servlet engine, was part of the Apache ecosystem (used in early versions of Apache Cocoon and others).
- Publish Servlet API 2.1/2.2 (Web ARchiv Format)
- Publish the Apache JServ Protocol Version 1.1
- JSP Standard Tag Library (JSTL) 
- AMG GmbH Dortmund implemented the IntraNEWS information platform on a distributed network of over 5000 Linux nodes, utilizing Apache JServ as the servlet container for handling dynamic content.
- Independent servlet containers like Jo! (by Peter Rossbach && Hendrik Schreiber) emerged.
- Peter and Hendriks “Java Server and Servlets”, one of the first books covering servlet tech. (Mar 1999)
- Servlet/ JSP Patent von James Goesling

## 1999: Tomcat Goes Open Source

- Davidson convinced Sun to open-source Tomcat Servlet Spec Reference Implemntation under the Apache Software Foundation.
- It was renamed Tomcat and contributed to the newly formed Jakarta Project at Apache.
- Integration of the JServ implementation 
- Tomcat became reference implementation for Servlet API and JSP.
- Contributed heavily to Apache Commons and was pivotal in the development of Apache Ant (initially created to build Tomcat itself).

## 2000: Catalina Architecture by Craig McClanahan

- Tomcat underwent a complete rearchitecture, introducing the Catalina engine.
- Craig McClanahan led this effort to modularize and improve Tomcat’s internal structure.
- Catalina provided a flexible and embeddable servlet container, and still serves as the core of modern Tomcat versions.
- Enabled advanced features like pluggable realms, valves, and a more manageable lifecycle with JMX Beans.
- Tomcat underwent a complete rearchitecture, resulting in the creation of Catalina, the new servlet container engine.
- Craig McClanahan led this redesign, aiming for a modular and flexible architecture aligned with Servlet API 2.3.
  - JSR 53: Servlet 2.3 and JSP 1.2
  - Catalina introduced components like Coyote (HTTP connector) and JaSPer (JSP engine - JAva Server Page compilER).
- The name "Catalina" was inspired by James Duncan Davidson's fondness for Catalina Island and considerations of using the Avalon framework, a town on the island.
- Apache Struts - MVC Web Application Framework
- Apache Cocoon - XML/XLST Web Application Middleware / Datawarehousing ETL

## 2001–2004: Modular Growth

- Catalina's architecture solidified, separating concerns like connectors (Coyote) and containers (Catalina).
- Tomcat versions 4.x and 5.x gained widespread adoption in enterprise and open-source projects.
- Peter began contributing to the Apache Tomcat project and actively promoted its adoption through technical talks and presentations at industry conferences.
- Java Server Faces (JSF 2001)
- Spring Framework as lightweight alternative to J2EE Programming Model (2002)

## 2005: Major Milestones

- Tomcat became an Apache Top-Level Project, graduating from the Jakarta Project.
- Sun Microsystems formally handed over long-term stewardship.
- Continued as a core component in Java EE servers like JBoss, Apache TomEE, and Geronimo.
- Tomcat's user base and professional installations grew rapidly, prompting a stronger focus on hardening and production readiness.
- Nine years after its debut as the reference implementation of the Servlet API, Tomcat had become the de facto standard for Java-based web applications.

## 2014: Spring Boot Uses Embedded Tomcat

- Spring Boot, the groundbreaking Java microservices framework, adopted embedded Tomcat as the default servlet container.
- Reinforced Tomcat’s dominance in the Java ecosystem, especially in microservice architectures.

## 2018: Eclipse Foundation and Jakarta EE

- Oracle transferred Java EE to the Eclipse Foundation under the name Jakarta EE.
- Marked the beginning of renaming core Java EE packages (javax.* to jakarta.*), affecting all servlet containers including Tomcat.

## 2020: Jakarta Servlet Renaming

- Servlet API, JSP, and related specs officially transitioned to the jakarta.* namespace.
- Tomcat adapted to support these new namespaces in later versions (starting from Tomcat 10).

## 2024–2025: Tomcat 11 and Beyond

- Tomcat 11 becomes the latest major version.
- Fully supports Jakarta EE 10 (and upcoming EE 11).
- Reflects nearly 26/29 years of innovation in Java Web Technology.

## References & Key Contributions

Books:

- Java Servlet Programming by Jason Hunter
- Java Server and Servlets by Peter Rossbach, Hendrik Schreiber
- Tomcat: The Definitive Guide by Jason Brittain, Ian F. Darwin
- Professional Apache Tomcat 6 by Vivek Chopra

Technologies influenced:

- Apache Ant, Commons, Spring Boot, MicroProfile, and more.

Notable Contributors:

- James Duncan Davidson (Creator of tomcat)
- Craig McClanahan(Creator of the Catalina Architecture)
- Remy Maucherat (Core Developer and Long-time Maintainer)
- Mark Thomas (Current Release Manager and PMC Chair)
- Rainer Jung (HTTPD and Tomcat Contributor & Performance Expert, mod_jk)
- Filip Hanik (Tomcat Comet and Clustering Developer)
- Jean-Frederic Clere (Tomcat & Web Server Integration Specialist)
- Peter Rossbach (Clustering Developer,JMX, mod_jk)

and the fantastic Apache community
- comprising users, maintainers and many committers
— whose collaborative efforts continue to drive the evolution and stability of the project.

## References:

- [Apache Tomcat](https:/tomcat.apache.org)
- https://svn.apache.org/repos/asf/tomcat/archive/tc3.2.x/trunk/container/STATUS.html
- https://technotif.com/the-origin-story-of-tomcat/
- https://web.archive.org/web/20030804080332/http://java.apache.org/jserv/protocol/AJPv11.html
- https://intojava.wordpress.com/2022/03/22/meet-tomcat-catalina/?utm_source=chatgpt.com
- https://tecnoesis.wordpress.com/2013/12/07/tomcat-primer/?utm_source=chatgpt.com
- [JSR 53: JavaTM Servlet 2.3 and JavaServer PagesTM 1.2 Specifications](https://www.jcp.org/en/jsr/detail?id=53)
- [Jakarta_Servlet](https://en.wikipedia.org/wiki/Jakarta_Servlet)
- [Servlet API 2.1a](https://web.archive.org/web/20090611171402/http://java.sun.com/products/servlet/2.1/servlet-2.1.pdf)
- [Serlvet Timeline - Json Hunter](https://images.slideplayer.com/2/687571/slides/slide_4.jpg)
- [Jakarta Faces](https://en.wikipedia.org/wiki/Jakarta_Faces)
- [Apache Struts 1](https://en.wikipedia.org/wiki/Apache_Struts_1)
- [Apache Cocoon](https://en.wikipedia.org/wiki/Apache_Cocoon)
- [Tomcat Architecture](https://de.slideshare.net/slideshow/ss-56543446/56543446)