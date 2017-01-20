<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<!DOCTYPE>
<html>
<head>
    <title>wsChat</title>
</head>
<body>
<link href="<%=path%>/static/css/login.css" rel='stylesheet' type='text/css' />
<script type="application/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-2.1.4.min.js"></script>
<h1>WebSocket chat form</h1>
<div class="login-form">
    <div class="close"> </div>
    <div class="head-info">
        <label class="lbl-1">1</label>
        <label class="lbl-2">2</label>
        <label class="lbl-3">3</label>
    </div>
    <div class="clear"> </div>

    <div class="avtar"><img src="<%=path%>/static/img/avtar.png" /></div>
    <form id="formLogin" action="/doLogin" method="post">

            <label>用户名称：</label>
        <input type="text" id = "userid" name="userid" placeholder="请输入用户名称id"><br>

        <div class="key">
            <label>用户密码：</label>
           <input type="password" id = "password" name="password" placeholder="请输入用户密码"><br>
        </div>
        <div class="signin">
        <input type="submit" value="登录" onclick="onSubmit()">
        </div>
    </form>
</div>

<script>
    function onSubmit(){
        var userid = $("#userid").val;
        if(userid == ''){
            alert("请输入用户id");
            return false;
        }
        var params = {
            "userid" : $("#userid").val,
            "password" : $("#password").val
        };
//        $("#formLogin").submit();
        $.ajax({
            data:$("#formLogin").serialize(),
            type: "post" ,
            dataType : "json",
            url:"user/login",
            success : function(data){
                if(data.success){
                    alert(1);
                    $("#formLogin").submit();
                }else{
                    alert(data.msg)
                }
            }
        })
    }
</script>
</body>

</html>
