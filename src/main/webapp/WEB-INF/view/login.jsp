<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script src="<%=path%>/static/jquery/jquery-2.1.4.min.js"></script>
<h1>Hello world!!!</h1>
<div>

    <h1><%=path%> 111</h1>
    <form id="formLogin" action="/login/userLogin" method="post">
        <label>
            用户名：
        </label><input type="text" id="userid" name="userid" value=""><br>
        <label>
            用户密码：
        </label><input type="password" id = "password" name="password"><br>
        <input type="button" value="登录" onclick="onSubmit()">
    </form>
</div>
</body>

<script>
    console.log()
    function onSubmit(){
        var userid = document.getElementById("userid").value;
        console.log(userid);
        if(userid == ''){
            return false;
        }
        alert(1);
//        $("#formLogin").submit();
    }
</script>
</html>
