<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Card Funding</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <style>
        .transfer-form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: left;
        }
        .form-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group select, .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-cancel {
            background-color: #f0f0f0;
            color: #333;
        }
        .btn-continue {
            background-color: #2ecc71;
            color: white;
        }
        .error {
            color: #ff4444;
            font-size: 12px;
            display: none;
            margin-top: 5px;
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
            <div class="transfer-form-container">
                <h2 class="form-title">Card Funding</h2>
                
                <form id="cardFundingForm" action="confirmCardFunding.jsp" method="post" onsubmit="return validateForm(event)">
                    <div class="form-group">
                        <label>From Account</label>
                        <select id="fromAccount" name="fromAccount">
                            <option value="">Select account</option>
                            <option value="Checking-12345">Checking (USD 5,000.00)</option>
                            <option value="Saving-67890">Saving (USD 10,000.00)</option>
                        </select>
                        <div id="fromAccountError" class="error">Please select a from account.</div>
                    </div>
                    
                    <div class="form-group">
                        <label>To Card</label>
                        <select id="toCard" name="toCard">
                            <option value="">Select card</option>
                            <option value="Credit-98765">Credit Card (9876)</option>
                            <option value="Debit-54321">Debit Card (5432)</option>
                        </select>
                        <div id="toCardError" class="error">Please select a card.</div>
                    </div>
                    
                    <div class="form-group">
                        <label>Amount</label>
                        <input type="number" id="fundingAmount" name="fundingAmount" min="0" step="0.01" placeholder="0.00">
                        <div id="amountError" class="error">Please enter a valid amount.</div>
                    </div>
                    
                    <div class="form-group">
                        <label>Description</label>
                        <input type="text" id="fundingDescription" name="fundingDescription" placeholder="Optional description">
                    </div>
                                     
                    <div class="button-group">
                        <button type="button" class="btn btn-cancel" onclick="goBack()">Back</button>
                        <button type="submit" class="btn btn-continue">Continue</button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script>
        function validateForm(event) {
            event.preventDefault();
            let isValid = true;

            const fromAccount = document.getElementById('fromAccount').value;
            const toCard = document.getElementById('toCard').value;
            const fundingAmount = document.getElementById('fundingAmount').value;

            // Reset error messages
            document.getElementById('fromAccountError').style.display = 'none';
            document.getElementById('toCardError').style.display = 'none';
            document.getElementById('amountError').style.display = 'none';

            if (!fromAccount || fromAccount === '') {
                document.getElementById('fromAccountError').style.display = 'block';
                isValid = false;
            }

            if (!toCard || toCard === '') {
                document.getElementById('toCardError').style.display = 'block';
                isValid = false;
            }

            if (!fundingAmount || isNaN(fundingAmount) || fundingAmount <= 0) {
                document.getElementById('amountError').style.display = 'block';
                isValid = false;
            }

            if (isValid) {
                document.getElementById('cardFundingForm').submit();
            }

            return isValid;
        }

        function goBack() {
            window.location.href = '../transfers.jsp'; // Attempt public transfers.jsp
            setTimeout(() => {
                if (window.location.pathname.includes('cardFunding.jsp')) {
                    window.location.href = '/'; // Fallback to context root
                }
            }, 100);
        }
    </script>
</body>
</html>