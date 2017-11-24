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
    <title></title>
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

        input[type=text],select{
            position: absolute;
            left: 130px;
            width:200px;
            height:24px;
        }

        img{
            width:20px;
            height:20px;
            float: left;
            margin-left:100px;
        }

        button{
            width:60px;
        }

        input[type=number]{
            position:absolute;
            left:334px;
            width:40px;
            height:24px;
        }


    </style>
</head>
<body>
<form class="well form-search" action="" onsubmit="return false">
    <div>
        <label>交易编号:</label>
        <input type="text" class="input-medium search-query" name="tid">
    </div>
    <div>
        <label>买家昵称:</label>
        <input type="text" class="input-medium search-query" name="buyerNick">
    </div>
    <div>
        <label>实付金额:</label>
        <input type="text" class="input-medium search-query" name="payment">
    </div>
    <div>
        <label>状态:</label>
        <select>
            <option></option>
            <option value="等待付款">等待付款</option>
            <option value="已经付款">已经付款</option>
            <option value="等待发货">等待发货</option>
            <option value="已发货">已发货</option>
            <option value="交易成功">交易成功</option>
            <option value="交易成功">交易关闭</option>
            <option value="退款中">退款中</option>
        </select>
    </div>
    <div>
        <label>收货地址:</label>
        <input type="text" class="input-medium search-query" name="receiverAddress">
    </div>
    <div>
        <label>收货人电话:</label>
        <input type="text" class="input-medium search-query" name="receiverMobile">
    </div>
    <div>
        <label>收货人姓名:</label>
        <input type="text" class="input-medium search-query" name="receiverName">
    </div>
    <div>
        <label>备注:</label>
        <input type="text" class="input-medium search-query" name="sellerMemo">
    </div>
    <div>
        <label>手改金额:</label>
        <input type="text" class="input-medium search-query" name="discountFee">
    </div>
    <div id="last">
        <img src="../static/img/plus.png" onclick="plusRow()"/>
        <button onclick="subData()">确认</button>
        <button onclick="cancel()">取消</button>
    </div>

</form>

</body>
</html>

<script>
    var count=1;
    function cancel(){
        parent.hideModel();
    }

    function subData(){
        var param=$('form').serialize();
        var status=$('form>div:eq(3)>select').val();
        if(status==null||status.trim()==''){
            alert('请选择订单状态');
            return;
        }else{
            param+='&status='+status;
        }

        //获取所有items
        var allItems=new Array();
        $('.item').each(function(index,value){
            var obj=new Object();
            itemId=$(this).val();
            //获取数量
            num=$(this).next().val();
            if(itemId==null||itemId.trim()==''||num<=0){
                return true;
            }
            obj.itemId=itemId;
            obj.num=num;
            allItems.push(obj);
        })
        if(allItems.length==0){
            alert('请添加商品');
            return;
        }
        param+='&data='+JSON.stringify(allItems);


        $.ajax({
            url:'${pageContext.request.contextPath}/order/insertData',
            data:param,
            dataType:'text',
            type:'post',
            success:function(data){
                if(data=='true'){
                    parent.hideModel({});
                    var data=parent.myframe.init({});
                    parent.myframe.sideReload(data);
                    parent.myframe.bindHover();
                }else{
                    alert('反正你肯定哪里写错了，我不管')
                }
            }
        })
    }

    function plusRow(){
        var data=parent.ajaxSend('${pageContext.request.contextPath}/order/allItems',false,{});
        var label=$('<label>商品'+count+':</label>');
        var combo=$('<select class="item"><option></option></select>');
        $(data).each(function(index,value){
            var opt;
            if(value.propertiesNames==null){
                opt=$('<option value="'+value.id+'">'+value.title+'</option>');
            }else{
                opt=$('<option value="'+value.id+'">'+value.title+'-'+value.propertiesNames+'</option>');
            }
            combo.append(opt);
        });
        var num=$('<input type="number" value=1>');
        var div=$('<div></div>')
        div.append(label).append(combo).append(num);
        $('#last').before(div);
        count++;
        var modelHeight=parent.getModelHeight();
        var inputHeight=num.height();
        parent.changeHeight(modelHeight+inputHeight+5);
    }
</script>
