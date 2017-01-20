
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

            console.log("message type")
        }
        if(message.type =='notice'){
            // $("#chat").append(111);
            showNotice(message.message);
        }
        if(message.type =='onLine'){
            console.log("onLine type")
        }

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


</script>
</body>
</html>
