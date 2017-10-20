<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/10/20
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="../plugs/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="../plugs/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../plugs/js/bootstrap-table.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../static/css/bootstrap-table.min.css">
    <title>updateorder</title>
    <style>
        * {
            padding: 0;
            margin: 0;
            font-family: Consolas;
        }

        body {
            background-color: #EAF5FF;
            padding: 10px;
            overflow: hidden;
        }

        form div {
            margin-top: 10px;
        }

        form div input {
            position: absolute;
            left: 100px;
        }

        button {
            width: 50px;
            height: 30px;
        }

    </style>
</head>
<body>
<form class="well form-search">
    <div>
        <label>订单号:</label>
        <input type="text" class="input-medium search-query" name="orderNum">
    </div>
    <div>
        <label>旺旺号:</label>
        <input type="text" class="input-medium search-query" name="wangwang">
    </div>
    <div>
        <label>地址:</label>
        <input type="text" class="input-medium search-query" name="address">
    </div>
    <div>
        <labe>实付金额:</labe>
        <input type="text" class="input-medium search-query" name2="realityPay">
    </div>
    <div>
        <button onclick="subData()">确认</button>
        <button onclick="cancel()">取消</button>
    </div>

</form>

</body>
</html>

<script>
    var x=0;
    function cancel() {
        parent.hideModel();
    }

    function subData() {
        var id = '${param.id}';
        var realityPay=$('input[name2]').val();
        $.ajax({
            url: '${pageContext.request.contextPath}/order/updateOrder',
            data: $('form').serialize() + '&' + $.param({id: id})+'&'+$.param({realityPay:parseFloat(realityPay)}),
            type: 'GET',
            success: function (data) {
                x++;
                alert('1111')
            }
        })
        alert(x)
    }
</script>
