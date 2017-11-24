<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/10/19
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>orderTable</title>
    <script type="text/javascript" src="../plugs/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="../plugs/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../plugs/js/bootstrap-table.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../static/css/bootstrap-table.min.css">

    <style>
        * {
            padding: 0px;
            margin: 0px;
        }

        body {
            overflow: scroll;
            padding: 10px;
        }

        #side {
            display: inline-block;
            width: 300px;
            height: 100%;
            background-color: #C1C6C6;
            position: fixed;
            right: -300px;
            top: 0px;
            opacity: 1;
            padding: 10px;
            text-align: center;
            box-shadow: 5px 5px 5px 5px black;
        }

        li > button {
            width: 80%;
        }

        #side img {
            width: 20px;
            height: 20px;
            position: absolute;
            top: 40%;
            right: 310px;
        }

        ul {
            list-style: none;
        }

        ul li {
            margin-top: 10px;
        }

        table {
            width: 90%;
            text-align: center;
            margin-top: 20px;
        }

        table td {
            height: 50px;
            font-size: 0.6em;
            width: 30%
        }

        span {
            margin-right: 15%;
            font-weight: 900;
            font-family: Consolas;
        }

        table > tr:first-child {
            background-color: #F5F5F5;
            font-size: 1em;
        }

        label {
            margin-left: 10px;
        }

        #time {
            margin-bottom: 5px;
        }

        input {
            width: 150px;
        }

        button {
            width: 50px;
        }

        #sideTable tr * {
            text-align: center;
            height: 30px;
        }

        input[type='checkbox'] {
            width: 15px;
            height: 15px;
        }

        #batchDelete {
            background-color: red;
            color: white;
        }

        #createOrder {
            background-color: green;
            color: white;
        }


    </style>

</head>
<body>
<div id="query">
    <div id="time">
        <label>成交时间:</label><input type="date" name="start">~<input type="date" name="end">
    </div>
    <div>
        <label>收件人姓名:</label><input type="text" name="receiveman">
        <label>收件人手机:</label><input type="text" name="receivetele">
        <label>宝贝关键字:</label><input type="text" name="order">
        <label>地址关键字:</label><input type="text" name="address">
        <button onclick="query()">查询</button>
    </div>
</div>
<div id="tables">

</div>
<div id="side">
    <img src="../static/img/shouqi.png" onclick="show()"/>
    <ul>
        <li>
            <button id="createOrder" onclick="createTrade()">快速建单</button>
        </li>
        <li>
            <button id="batchDelete" onclick="batchDelete()">批量删除</button>
        </li>
        <li>
            <table id="sideTable">
                <tr>
                    <th><input onclick="selectAll()" type="checkbox" style="width:1em;height:1em;"></th>
                    <th>订单号</th>
                    <th>创建时间</th>
                </tr>
            </table>
        </li>

    </ul>
</div>
</body>
</html>

<script>
    $(function () {
        //数据初始化
        var data = init({});
        console.log(data)
        sideReload(data)
        bindHover();
    })

    function show() {
        if ($('#side').attr('complete') == 'true') {
            $("#side").animate({
                right: -300
            }, "slow");
            $('#side').attr('complete', '');
        } else {
            $("#side").animate({
                right: 0
            }, "slow");
            $('#side').attr('complete', true);
        }
    }


    function init(param) {
        $('#tables').html('');
        var data = parent.ajaxSend('${pageContext.request.contextPath}/order/orderList', false, param);
        $(data).each(function (i, v) {
            var table = $('<table border="1"></table>');
            var year = eval(v.created.year + 1900);
            var month = eval(v.created.month + 1);
            var date = v.created.date;
            var hour = v.created.hours;
            var minutes = v.created.minutes;
            var seconds = v.created.seconds;
            var createTime = year + '-' + month + '-' + date + ' ' + hour + ':' + minutes + ':' + seconds;
            var titles = $('<tr><td colspan="3"><span>状态:' + v.status + '</span><span>昵称:' + v.buyerNick + '</span><span>订单号:' + v.tid + '</span><span>成交时间:' + createTime + '</span></td></tr>');
            table.append(titles);

            var length = v.orders.length;
            $(v.orders).each(function (index, value) {
                var tr = $('<tr><td>' + value.title + '</td><td>' + parseFloat(value.price).toFixed(2) + 'x' + parseFloat(value.num) + '</td></tr>');
                if (index == 0) {
                    total = $('<td rowspan="' + length + '">实付:￥' + v.payment + '</td>');
                    tr.append(total);
                }
                table.append(tr);
            })
            $('#tables').append(table);
        })
        return data;
    }

    function query() {
        var start = $('input[name=start]').val();
        var end = $('input[name=end]').val();
        var receiveman = $('input[name=receiveman]').val();
        var receivetele = $('input[name=receivetele]').val();
        var order = $('input[name=order]').val();
        var address = $('input[name=address]').val();
        var obj = new Object();
        if (!isEmpty(start) && isEmpty(end)) {
            alert('请输入结束时间');
            return;
        }
        if (!isEmpty(end) && isEmpty(start)) {
            alert('请输入开始时间');
            return;
        }
        if (end < start) {
            alert('结束时间必须大于开始时间');
            return;
        }
        var obj = new Object();
        obj.start = start;
        obj.end = end
        if (!isEmpty(receiveman)) {
            obj.receiveman = receiveman.trim();
        }

        if (!isEmpty(receivetele)) {
            obj.receivetele = receivetele.trim();
        }

        if (!isEmpty(order)) {
            obj.order = order.trim();
        }

        if (!isEmpty(address)) {
            obj.address = address.trim();
        }

        //重新加载整个页面
        var data = init({query: JSON.stringify(obj)})
        //添加到侧边栏
        sideReload(data);
        bindHover();
    }

    function isEmpty(string) {
        if (string == null || string.trim() == '' || string == undefined) {
            return true;
        } else {
            return false;
        }
    }

    function createTrade() {
        parent.newWin(400, 300, '${pageContext.request.contextPath}/order/toCreateOrder');
    }

    function singOrder(tid) {
        init({query: JSON.stringify({tid: tid})});
    }

    //加载侧边栏
    function sideReload(data) {
        $('#sideTable tr').not('#sideTable tr:eq(0)').remove();
        $(data).each(function (i, v) {
            var table = $('<table border="1"></table>');
            var year = eval(v.created.year + 1900);
            var month = eval(v.created.month + 1);
            var date = v.created.date;
            var hour = v.created.hours;
            var minutes = v.created.minutes;
            var seconds = v.created.seconds;
            var createTime = year + '-' + month + '-' + date + ' ' + hour + ':' + minutes + ':' + seconds;
            var tr = $('<tr onclick="singOrder(\'' + v.tid + '\')"><td><input type="checkbox"></td><td>' + v.tid + '</td><td>' + createTime.substring(0, 11) + '</td></tr>');
            $('#sideTable').append(tr);
        })
    }

    //侧边栏的hover事件，在第一次初始化和query的时候分别绑定上
    function bindHover() {
        var time;
        $('#sideTable tr').bind('mouseenter', function () {
                var clickNum = 0;
                $(this).css('background-color', '#74CBFA').css('cursor', 'hand');
                var queren = $('<button style="height:0px;width:100%;color:green" onclick="update(\''+$(this).children('td:eq(1)').html()+'\')">修改</button>');
                time = $(this).children('td:eq(2)').html();
                $(this).children('td:eq(2)').html('').append(queren);
                queren.animate({
                    height: 30
                }, 100);
            }
        )

        $('#sideTable tr').bind('mouseleave', function () {
            $(this).css('background-color', '').css('cursor', '');
            $(this).children('td:eq(2)').html(time);
        })
    }

    function selectAll() {
        var ck = $('input[type=checkbox]:eq(0)');
        if (ck.is(':checked')) {
            $('input[type=checkbox]').prop('checked', 'checked');
        } else {
            $('input[type=checkbox]').prop('checked', false);
        }
    }

    function batchDelete() {
        var cks = $('input[type=checkbox]:gt(0)');
        var array = [];
        $(cks).each(function (index, value) {
            if(!$(this).is(':checked')){
                return true;
            }
            var tid = $(this).parent().next().html();
            array.push(tid);
        })
        if(array.length==0){
            return;
        }
        var param = array.join("-");

        $.ajax({
            url: '${pageContext.request.contextPath}/order/batchDelete',
            type: 'post',
            data: {tids:param},
            dataType: 'text',
            success: function (re) {
                if (re == 'true') {
                    var data=init({});
                    sideReload(data);
                    bindHover();
                } else {
                    alert('删除失败');
                }
            }
        })
    }

    function update(tid){
        parent.newWin(400,300,'${pageContext.request.contextPath}/order/updateOrder?tid='+tid);
    }

</script>
