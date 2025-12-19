<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 11/29/2025
  Time: 11:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>VetCare Clinic</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f4f6f9;
        }
        .card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
            width: 420px;
            text-align: center;
        }
        h1 {
            margin: 0 0 10px 0;
            font-size: 34px;
        }
        p {
            margin: 0 0 25px 0;
            color: #555;
        }
        .actions {
            display: flex;
            gap: 12px;
            justify-content: center;
        }
        .btn {
            display: inline-block;
            padding: 12px 18px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            border: 2px solid #2c3e50;
            color: #2c3e50;
            background: transparent;
            transition: 0.15s;
        }
        .btn:hover {
            transform: translateY(-1px);
        }
        .btn.primary {
            background: #2c3e50;
            color: white;
        }
    </style>
</head>
<body>

<div class="card">
    <h1>VetCare Clinic</h1>
    <p>Aceda à sua conta ou crie uma nova conta.</p>

    <div class="actions">
        <a class="btn primary" href="<%= request.getContextPath() %>/login">Login</a>
        <a class="btn" href="<%= request.getContextPath() %>/register">Crie uma Conta</a>
    </div>
</div>

</body>
</html>
