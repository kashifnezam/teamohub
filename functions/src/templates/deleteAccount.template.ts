export const renderDeleteAccountPage = () => `
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Account</title>

<style>
body{
margin:0;
font-family:Arial;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
background:#f5f5f5;
}
.card{
width:360px;
background:#fff;
padding:24px;
border-radius:12px;
box-shadow:0 5px 20px rgba(0,0,0,.1);
}
input,button{
width:100%;
padding:12px;
margin-top:12px;
border-radius:8px;
border:1px solid #ddd;
box-sizing:border-box;
}
button{
background:#4F46E5;
color:#fff;
border:none;
cursor:pointer;
}
</style>

</head>

<body>

<div class="card">

<h2>Delete Account</h2>

<form action="/delete-account/send-otp" method="POST">

<input
type="email"
name="email"
placeholder="Enter Email"
required>

<button type="submit">
Get OTP
</button>

</form>

</div>

</body>
</html>
`;