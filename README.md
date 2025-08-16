# MazeBank Banking Management System


## Installation and Setup

To install and run the MazeBank project, you will need the following prerequisites:

* **Eclipse EE IDE**
* **Apache Tomcat 10** (installed and configured)
* **A `db.properties` file** containing your database credentials

### Step-by-Step Guide

1.  **Open IDE**: Launch your Eclipse EE IDE.
2.  **Open Project**: Select "Open existing Maven project" and navigate to the project folder.
3.  **Clean Project**: Go to the project section and clean the project.
4.  **Update Maven**: Right-click on the project, go to **Maven**, and click on **Update Project**. Make sure to check the box for **Force Update of Snapshots/Releases**.
5.  **Run on Server**: Navigate to the `index.jsp` file, right-click, select **Run As**, and then **Run on Server**.

## Project Overview

MazeBank is a comprehensive banking management system designed to provide secure and efficient banking services through a web-based platform. Developed as a Java web application, MazeBank aims to offer a robust solution for managing various banking operations for both bank customers and administrators. This project was developed by Group F, which includes Henilkumar Prafulchandra Patel, Francis Ugorji, Varunkumar Amin, Chahat Patel, and Shashank Lalpurwala.

---

## Key Features

MazeBank offers a wide array of features to facilitate seamless banking operations for its target users: bank customers (account holders) and bank administrators.

* **Secure User Authentication and Authorization**: Implements robust security measures including jBCrypt for password hashing and a custom `AuthFilter` for role-based access control, ensuring that only authorized users can access specific functionalities.
* **Account Management and Transaction Processing**: Provides functionalities for managing various types of bank accounts, allowing users to view account details, balances, and transaction histories. It supports efficient processing of deposits, withdrawals, and transfer between account transactions.
* **Wire Transfers and Payment Services**: Enables users to perform wire transfers between users and facilitates various payment services, ensuring secure and reliable fund transfers.
* **Administrative Tools for Bank Staff**: Offers a dedicated administrative portal with tools for user management, account administration, transaction monitoring, and audit functionalities.

---

## System Architecture

MazeBank implements a **Model-View-Controller (MVC)** architecture pattern, which promotes a clear separation of concerns, making the codebase modular, maintainable, and scalable. The system is structured into distinct layers, each responsible for a specific set of functionalities:

* **Presentation Layer (View)**: This layer is responsible for rendering the user interface and displaying dynamic content. It primarily utilizes JSP (JavaServer Pages) and JSTL (JSP Standard Tag Library) to create interactive and responsive web pages for both customer and administrative portals.
* **Application Layer (Controller)**: Acting as the intermediary between the Presentation and Business Layers, the Controller handles HTTP requests, manages user authentication, and coordinates the flow of business logic.
* **Business Layer (Model)**: This layer encapsulates the core banking functionality and business rules.
* **Data Access Layer (DAO)**: The Data Access Object (DAO) layer is responsible for abstracting and encapsulating all access to the data source.
* **Database**: **MySQL** serves as the relational database management system for MazeBank.

---

## Technologies Used

MazeBank is built using a modern and robust technology stack to ensure reliability, security, and maintainability. The primary technologies and frameworks utilized in this project include:

* **Backend**: The core of the application is developed using **Java 17**, leveraging its latest LTS features for robust and efficient server-side logic. **Jakarta EE 9.1** provides the enterprise framework for building web applications.
* **Database**: **MySQL 8.0** is used as the relational database management system.
* **Security**: **jBCrypt** is integrated for secure password hashing.
* **Build Tool**: **Apache Maven** is employed for build automation and dependency management.
* **Testing**: The project incorporates a comprehensive testing strategy using industry-standard Java testing frameworks. **JUnit 5** is used for unit and integration testing, and **Mockito** is utilized as a mocking framework.
* **Deployment**: **Apache Tomcat 10** serves as the application server for deploying the MazeBank web application.

---

## Database Design

MazeBank utilizes MySQL as its relational database management system, with a carefully designed schema to ensure data integrity, security, and efficient retrieval of banking information. The database design focuses on a relational structure, with key tables organized to manage various aspects of banking operations.

### Key Database Tables

* **Users**: This table stores comprehensive information about both bank customers and administrators, including authentication details, user roles, and personal information.
* **Accounts**: This table holds details about all bank accounts, including account numbers, current balances, account types, and status.
* **Transfers**: This table specifically manages internal fund transfers between accounts, tracking the source and target accounts, amount, and status.
* **Transactions**: This table records all financial transactions, such as deposits, withdrawals, and fees, maintaining a complete audit trail.
* **Wire_Transfers**: This table handles details related to external wire transfers, including sender and recipient account information and the status of the transfer.
* **Logs**: This table serves as a comprehensive logging mechanism, recording sensitive actions and security events within the system for auditing and security monitoring.

## Testing Framework

MazeBank employs a comprehensive testing strategy to ensure the reliability, correctness, and stability of its banking operations. The project leverages industry-standard testing frameworks for Java applications, focusing on both isolated component testing and integrated system validation.

### Testing Approach

* **Unit Testing**: Individual components and methods are tested in isolation to verify their correct behavior and adherence to specifications. **JUnit 5** is the primary framework used for unit testing.
* **Integration Testing**: This type of testing focuses on verifying the interactions between different components and modules of the system.
* **Service Layer Testing**: Specific attention is given to testing the business logic implemented within the service layer.

---

## Deployment Process

MazeBank utilizes a streamlined deployment process, leveraging **Apache Maven** for build automation and **Apache Tomcat** as the application server.

### Deployment Workflow

* **Source Code Management**: The project's source code is maintained in a version control system (e.g., Git) with a proper branching strategy.
* **Maven Build Process**: Developers use Apache Maven to build the project. Maven automatically compiles the Java source code, runs unit and integration tests, and resolves all project dependencies.
* **WAR Packaging**: After a successful build, Maven packages the entire application into a single Web Application Archive (**WAR**) file.
* **Tomcat Deployment**: The generated WAR file is then deployed to an Apache Tomcat server.

---

## Future Enhancements

To further enhance MazeBank and expand its capabilities, the following future enhancements are envisioned:

* Include more roles and responsibility.
* Chat bot for customers.
* Advanced analytics and personalized financial insights.
* Transition from a monolithic application to a microservices architecture to improve scalability, resilience, and independent deployability of individual services.

---

## Final Takeaway

MazeBank stands as a testament to how modern Java technologies can be effectively leveraged to create secure, scalable, and maintainable banking applications. It is designed to meet the evolving needs of both customers and financial institutions in today's rapidly advancing digital banking landscape, providing a solid foundation for future growth and innovation.