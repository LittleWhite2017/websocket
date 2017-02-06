
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="include/common.jsp"/>
    <script src="${ctx}/static/plugins/sockjs/sockjs.js"></script>
</head>
<body>
<jsp:include page="include/header.jsp"/>
<div class="am-cf admin-main">
    <jsp:include page="include/sidebar.jsp"/>
    <div class="admin-content">
        <div class="" style="width: 80%;float:left;">
                <!-- 聊天区 -->
            <div class="am-scrollable-vertical" id="chat-view" style="height: 510px;">
                <ul class="am-comments-list am-comments-list-flip" id="chat">
                </ul>
            </div>
            <!--功能-->
            <!-- 输入区 -->
            <div class="am-form-group am-form">
                <textarea class="" id="message" name="message" rows="5"  placeholder="这里输入你想发送的信息..."></textarea>
            </div>
            <!-- 接收者 -->
            <div class="" style="float: left">
                <p class="am-kai">发送给 : <span id="sendto">全体成员</span><button class="am-btn am-btn-xs am-btn-danger" onclick="$('#sendto').text('全体成员')">复位</button></p>
            </div>
            <!-- 按钮区 -->
            <div class="am-btn-group am-btn-group-xs" style="float:right;">
                <button class="am-btn am-btn-default" type="button" onclick="getConnection()"><span class="am-icon-plug"></span> 连接</button>
                <button class="am-btn am-btn-default" type="button" onclick="closeConnection()"><span class="am-icon-remove"></span> 断开</button>
                <button class="am-btn am-btn-default" type="button" onclick="checkConnection()"><span class="am-icon-bug"></span> 检查</button>
                <button class="am-btn am-btn-default" type="button" onclick="clearConsole()"><span class="am-icon-trash-o"></span> 清屏</button>
                <button class="am-btn am-btn-default" type="button" onclick="sendMessage()"><span class="am-icon-commenting"></span> 发送</button>
            </div>
        </div>
        <div class="am-panel am-panel-default" style="float:right;width: 20%;">
            <div class="am-panel-hd">
                <h3 class="am-panel-title">在线列表 [<span id="onlinenum"></span>]</h3>
            </div>
            <ul class="am-list am-list-static am-list-striped" >
                <li>图灵机器人 <button class="am-btn am-btn-xs am-btn-danger" id="tuling" data-am-button>未上线</button></li>
            </ul>
            <ul class="am-list am-list-static am-list-striped" id="list">
            </ul>
        </div>
    </div>
    <a href="#" class="am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}">
        <span class="am-icon-btn am-icon-th-list"></span>
    </a>
    <jsp:include page="include/footer.jsp"/>
</div>
<script>
    var wsUrl  = "ws://" + location.host+"${pageContext.request.contextPath}" ;
    var sock;
    getConnection();
    function getConnection() {
        if(sock==null){
            if ('WebSocket' in window) {
                sock = new WebSocket(wsUrl + "/socketServer");
            } else if ('MozWebSocket' in window) {

                sock = new MozWebSocket(wsUrl + "/socketServer");
            } else {

                sock = new SockJS(wsUrl + "/sock/socketServer");
            }
            sock.onopen = function (e) {
                console.log("建立连接")
            };
            sock.onmessage = function (e) {
                console.log(e);
                analysisMessage(e.data);  //解析后台传回的消息,并予以展示
            };
            sock.onerror = function (e) {
                console.log("产生异常");
            };
            sock.onclose = function (e) {
                console.log("已经关闭连接");
            }
        }else{
            layer.msg("连接已存在!", { offset: 0, shift: 6 });
        }

    }
    function analysisMessage(data){
        message = JSON.parse(data);
        if(message.type =='message'){
            showMessage(message.message);
            console.log("message type")
        }
        if(message.type =='notice'){
            showNotice(message.message);
        }
        if(message.type =='onLine'){
            console.log("onLine type")
        }

    }
    function showMessage(message){
        var to = message.to == null || message.to == ""? "全体成员" : message.to;   //获取接收人
        var isToSelf = '${userid}'== message.from ?"am-comment-flip" : "";//是否发送给自己
        var html = "<li class=\"am-comment "+isToSelf+" am-comment-primary\"><a href=\"#link-to-user-home\"><img width=\"48\" height=\"48\" class=\"am-comment-avatar\" alt=\"\" src=\"${ctx}/"
                +message.from+"/head\"></a><div class=\"am-comment-main\">\n" +
                "<header class=\"am-comment-hd\"><div class=\"am-comment-meta\">   " +
                "<a class=\"am-comment-author\" href=\"#link-to-user\">"+message.from+"</a> 发表于<time> "+message.time+"</time> 发送给: "+
                to+" </div></header><div class=\"am-comment-bd\"> <p>"+message.content+"</p></div></div></li>";
        $("#chat").append(html);
        $("#message").val("");  //清空输入区
        var chat = $("#chat-view");
        chat.scrollTop(chat[0].scrollHeight);   //让聊天区始终滚动到最下面
    }
    function closeConnection(){
        if(sock != null){
            sock.close();
            sock = null;
            $("#list").html("");    //清空在线列表
            layer.msg("已经关闭连接", { offset: 0});
        }else{
            layer.msg("未开启连接", { offset: 0, shift: 6 });
        }
    }
    /**
     * 展示提示信息
     */
    function showNotice(notice){
        $("#chat").append("<div><p class=\"am-text-success\" style=\"text-align:center\"><span class=\"am-icon-bell\"></span> "+notice+"</p></div>");
        var chat = $("#chat-view");
        chat.scrollTop(chat[0].scrollHeight);   //让聊天区始终滚动到最下面
    }

    function checkConnection(){
        if(sock){
            layer.msg("连接已存在", { offset: 0});
        }else{
            layer.msg("已经关闭连接", { offset: 0});
        }
    }
    function clearConsole(){
        $("#chat").html("");
    }
    function sendMessage(){
        if(sock == null ){
            layer.msg("连接未开启!", { offset: 0, shift: 6 });
            return;
        }
        var message = $("#message").val();
        var receiver = $("#sendto").text();
        sock.send(JSON.stringify({
            message : {
                content : message,
                to : receiver,
                from : '${userid}'
            },
            type : "message"
        }));
    }
</script>
</body>
</html>
