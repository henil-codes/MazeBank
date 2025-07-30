<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conformation</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <style>
        .transfer-confirm-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: left;
        }
        .confirm-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }
        .confirm-details {
            margin-bottom: 20px;
        }
        .confirm-details .account-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .confirm-details .account-row div {
            flex: 1;
            padding: 15px;
            background: #f5f5f5;
            border-radius: 5px;
            text-align: center;
            margin-right: 10px;
        }
        .confirm-details .account-row div:last-child {
            margin-right: 0;
        }
        .confirm-details .transfer-details div {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .confirm-details .transfer-details label {
            font-weight: bold;
            color: #555;
        }
        .confirm-details .transfer-details span {
            color: #333;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }
        .btn-back {
            background-color: #ff4444;
            color: white;
        }
        .btn-confirm {
            background-color: #2ecc71;
            color: white;
        }
        
        .logout-btn {
    background-color: #e74c3c; /* Red background for logout */
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    text-decoration: none;
    transition: background-color 0.3s ease;
    display: inline-block;
    margin-left: 10px;
    margin-right: 35px;
}

.logout-btn:hover {
    background-color: #c0392b; /* Darker red on hover */
    text-decoration: none;
    color: white;
}

.user-info {
    display: flex;
    align-items: center;
}

.notification {
    background-color: #ff4500;
    color: white;
    border-radius: 50%;
    padding: 2px 6px;
    margin-left: 5px;
    font-size: 12px;
}
    </style>
</head>
<body>
    <div class="container">
        <header>
    <div class="logo">Banking Management</div>
    <div class="user-info">
        Hello, Varun | 
        <a href="#" class="logout-btn">Log Out</a>
    </div>
</header>
        <nav class="sidebar">
            <ul>
                <li><a href="../accounts.jsp">ACCOUNTS</a></li>
                <li><a href="../cards.jsp">CARDS</a></li>
                <li><a href="transfers.jsp" class="active">TRANSFERS</a></li>
                <li><a href="../reports.jsp">REPORTS</a></li>
                <li><a href="../news.jsp">NEWS</a></li>
                <li><a href="../myprofile.jsp">MY PROFILE</a></li>
            </ul>
        </nav>
        <main>
            <div class="transfer-confirm-container">
                <h2 class="confirm-title">Confirm Transfer Between Users</h2>
                
                <div class="confirm-details">
                    <div class="account-row">
                        <div>
                            <label>From Account</label><br>
                            <%= request.getParameter("fromAccount") != null ? request.getParameter("fromAccount") : "" %>
                        </div>
                        <div>
                            <label>To User</label><br>
                            <%= request.getParameter("toUser") != null ? request.getParameter("toUser") : "" %>
                        </div>
                    </div>
                    <div class="transfer-details">
                        <div><label>Transfer Details</label></div>
                        <div><label>Amount</label> <span><%= request.getParameter("transferAmount") != null ? request.getParameter("transferAmount") + " USD" : "0.00 USD" %></span></div>
                        <div><label>TBA Fee</label> <span>0.00 USD</span></div>
                        <div><label>Description</label> <span><%= request.getParameter("transferDescription") != null ? request.getParameter("transferDescription") : "" %></span></div>
                        
                    </div>
                </div>
                
                <div class="button-group">
                    <button class="btn btn-back" onclick="goBack()">Back</button>
                    <button class="btn btn-confirm" onclick="confirmTransfer()">Confirm</button>
                </div>
            </div>
        </main>
    </div>

    <script>
        function goBack() {
            window.location.href = 'betweenUser.jsp'; // Relative path to the same directory
        }

        function confirmTransfer() {
            const fromAccount = "<%= request.getParameter("fromAccount") %>";
            const toUser = "<%= request.getParameter("toUser") %>";
            const transferAmount = "<%= request.getParameter("transferAmount") %>";

            if (!fromAccount || fromAccount === "" || !toUser || toUser === "" || !transferAmount || transferAmount === "" || isNaN(transferAmount) || transferAmount <= 0) {
                alert("Transaction cannot be confirmed. Please ensure all required fields are filled with valid data.");
                return;
            }

            alert("Transfer between users done successfully!");
            // Redirect to a public page instead of WEB-INF/transfers.jsp
            window.location.href = '../transfers.jsp'; // Attempt public transfers.jsp in WebContent/transfers/
            // Fallback to root if the public page doesn't exist
            setTimeout(() => {
                if (window.location.pathname.includes('confirmBetweenUser.jsp')) {
                    window.location.href = '/'; // Redirect to context root
                }
            }, 100);
        }
    </script>
</body>
</html>