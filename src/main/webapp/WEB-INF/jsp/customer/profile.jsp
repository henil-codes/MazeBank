<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mazebank.model.User"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .form-group input[readonly] {
            background-color: #f1f5f9;
            cursor: not-allowed;
        }
        .form-group input:not([readonly]) {
            background-color: #ffffff;
            cursor: text;
        }
        .edit-buttons {
            display: none;
            margin-top: 1rem;
        }
        .edit-mode .edit-buttons {
            display: block;
        }
        .edit-mode .update-profile-btn {
            display: none;
        }
    </style>
</head>
<body class="dashboard-body">
    <div class="dashboard-container">
        <%-- Include the sidebar fragment --%>
        <%@ include file="../fragments/_sidebar.jspf"%>
        <main class="main-content">
            <section class="welcome-section">
                <h1>Your Profile, <%=loggedInUser.getFirstName()%>!</h1>
                <p>Manage your personal information below</p>
                <p class="user-role">Role: <%=loggedInUser.getRole().name()%></p>
            </section>
            <%-- Display success or error messages --%>
            <%
            String message = request.getParameter("message");
            if (message != null) {
            %>
            <div class="alert <%= "ProfileUpdated".equals(message) ? "alert-success" : "alert-info" %>">
                <%
                if ("ProfileUpdated".equals(message)) {
                %>
                Profile updated successfully!
                <%
                } else if ("ProfileError".equals(message)) {
                %>
                Error updating profile. Please try again.
                <%
                }
                %>
            </div>
            <%
            }
            %>
            <section class="section profile-section">
                <h2 class="section-heading">
                    <i class="fas fa-user"></i> Profile Information
                </h2>
                <div class="form-card">
                    <form id="profileForm" action="${pageContext.request.contextPath}/app/customer/profile" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" value="<%=loggedInUser.getUsername()%>" required readonly>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%=loggedInUser.getEmail()%>" required readonly>
                        </div>
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" value="<%=loggedInUser.getFirstName()%>" required readonly>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" value="<%=loggedInUser.getLastName()%>" required readonly>
                        </div>
                       
                        <div class="form-group">
                            <label>Role</label>
                            <input type="text" value="<%=loggedInUser.getRole().name()%>" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label>Holder Type</label>
                            <input type="text" value="<%=loggedInUser.getHolderType().name()%>" readonly>
                        </div>
                        
                        <button type="button" class="btn btn-primary update-profile-btn" onclick="enableEditing()">Update Profile</button>
                        <div class="edit-buttons">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn btn-secondary" onclick="cancelEditing()">Cancel</button>
                        </div>
                    </form>
                </div>
            </section>
        </main>
    </div>
    <script>
        function enableEditing() {
            document.querySelectorAll('#profileForm input[readonly]').forEach(input => {
                if (input.id !== 'username') {
                    input.removeAttribute('readonly');
                }
            });
            document.body.classList.add('edit-mode');
        }

        function cancelEditing() {
            document.querySelector('#email').value = '<%=loggedInUser.getEmail()%>';
            document.querySelector('#firstName').value = '<%=loggedInUser.getFirstName()%>';
            document.querySelector('#lastName').value = '<%=loggedInUser.getLastName()%>';
            document.querySelectorAll('#profileForm input').forEach(input => {
                if (input.id !== 'username') {
                    input.setAttribute('readonly', 'readonly');
                }
            });
            document.body.classList.remove('edit-mode');
        }

        // Initialize page state
        document.addEventListener('DOMContentLoaded', () => {
            const message = '<%=message != null ? message : ""%>';
            if (message === 'ProfileUpdated') {
                // After successful update, stay in read-only mode
                document.body.classList.remove('edit-mode');
                document.querySelectorAll('#profileForm input').forEach(input => {
                    if (input.id !== 'username') {
                        input.setAttribute('readonly', 'readonly');
                    }
                });
            } else if (!document.body.classList.contains('edit-mode')) {
                // Ensure page loads in read-only mode by default
                document.querySelectorAll('#profileForm input').forEach(input => {
                    if (input.id !== 'username') {
                        input.setAttribute('readonly', 'readonly');
                    }
                });
            }
        });
    </script>
</body>
</html>