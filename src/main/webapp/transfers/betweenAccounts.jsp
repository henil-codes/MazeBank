<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transfer Between Accounts</title>
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
                <h2 class="form-title">Transfer Between Accounts</h2>
                
                <form id="transferForm" action="confirmTransfer.jsp" method="post" onsubmit="return validateForm(event)">
                    <div class="form-group">
                        <label>From Account</label>
                        <select id="fromAccount" name="fromAccount" onchange="validateSameAccounts()">
                            <option value="">Select account</option>
                            <option value="EBQ11233487456">EBQ11233487456 (EUR 189,803.13)</option>
                            <option value="EBQ113487654">EBQ113487654 (EUR 231,446.00)</option>
                        </select>
                        <div id="fromAccountError" class="error">Please select a from account.</div>
                    </div>
                    
                    <div class="form-group">
                        <label>To Account</label>
                        <select id="toAccount" name="toAccount" onchange="validateSameAccounts()">
                            <option value="">Select account</option>
                            <option value="EBQ113487654">EBQ113487654 (EUR 231,446.00)</option>
                            <option value="EBQ113487655">EBQ113487655 (USD 15,000.00)</option>
                        </select>
                        <div id="toAccountError" class="error">Please select a to account.</div>
                    </div>
                    
                    <div class="form-group">
                        <label>Amount</label>
                        <input type="number" id="transferAmount" name="transferAmount" min="0" step="0.01" placeholder="0.00">
                        <div id="amountError" class="error">Please enter a valid amount.</div>
                    </div>
                    
                    <div class="form-group">
                        <label>Description</label>
                        <input type="text" id="transferDescription" name="transferDescription" placeholder="Optional description">
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
        function validateSameAccounts() {
            const fromAccount = document.getElementById('fromAccount').value;
            const toAccount = document.getElementById('toAccount').value;
            const sameAccountError = document.getElementById('sameAccountError');

            if (!sameAccountError) {
                const errorDiv = document.createElement('div');
                errorDiv.id = 'sameAccountError';
                errorDiv.className = 'error';
                errorDiv.textContent = 'From and To accounts cannot be the same.';
                errorDiv.style.display = 'none';
                document.querySelector('.form-group:nth-child(2)').appendChild(errorDiv);
            }

            if (fromAccount && toAccount && fromAccount === toAccount) {
                document.getElementById('sameAccountError').style.display = 'block';
            } else {
                if (sameAccountError) sameAccountError.style.display = 'none';
            }
        }

        function validateForm(event) {
            event.preventDefault();
            let isValid = true;

            const fromAccount = document.getElementById('fromAccount').value;
            const toAccount = document.getElementById('toAccount').value;
            const transferAmount = document.getElementById('transferAmount').value;
            const sameAccountError = document.getElementById('sameAccountError');

            // Reset error messages
            document.getElementById('fromAccountError').style.display = 'none';
            document.getElementById('toAccountError').style.display = 'none';
            document.getElementById('amountError').style.display = 'none';
            if (sameAccountError) sameAccountError.style.display = 'none';

            if (!fromAccount || fromAccount === '') {
                document.getElementById('fromAccountError').style.display = 'block';
                isValid = false;
            }

            if (!toAccount || toAccount === '') {
                document.getElementById('toAccountError').style.display = 'block';
                isValid = false;
            }

            if (!transferAmount || isNaN(transferAmount) || transferAmount <= 0) {
                document.getElementById('amountError').style.display = 'block';
                isValid = false;
            }

            if (fromAccount === toAccount && fromAccount && toAccount) {
                if (!sameAccountError) {
                    const errorDiv = document.createElement('div');
                    errorDiv.id = 'sameAccountError';
                    errorDiv.className = 'error';
                    errorDiv.textContent = 'From and To accounts cannot be the same.';
                    document.querySelector('.form-group:nth-child(2)').appendChild(errorDiv);
                }
                document.getElementById('sameAccountError').style.display = 'block';
                isValid = false;
            }

            if (isValid) {
                document.getElementById('transferForm').submit();
            }

            return isValid;
        }

        function goBack() {
            // Try to navigate to a public page or root
            window.location.href = '../transfers.jsp'; // Attempt to go to WebContent/transfers/transfers.jsp
            // Fallback to root if the above fails (assuming a public index or default page)
            setTimeout(() => {
                if (window.location.pathname.includes('betweenAccounts.jsp')) {
                    window.location.href = '/'; // Redirect to context root (e.g., WebContent/)
                }
            }, 100);
        }
    </script>
</body>
</html>