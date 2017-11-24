<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/10/30
  Time: 15:01
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
    <title>Title</title>
    <style>
        *{
            padding:0px;
            margin:0px;
        }

        body{
            padding:10px;
            overflow: hidden;
        }

        iframe[name=unUsedFrame]{
            display: none;
        }

        input[type=text],select{
            position: absolute;
            left: 130px;
            width:200px;
            height:24px;
        }


        input[type=number]{
            position: absolute;
            left:334px;
            height:24px;
            width:40px;
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


    </style>
</head>
<body>
<form class="well form-search" action="" onsubmit="return false">
    <div>
        <label>交易编号:</label>
        <input type="text" class="input-medium search-query" name="tid" value="${trade.tid}" disabled>
    </div>
    <div>
        <label>买家昵称:</label>
        <input type="text" class="input-medium search-query" name="buyerNick" value="${trade.buyerNick}">
    </div>
    <div>
        <label>实付金额:</label>
        <input type="text" class="input-medium search-query" name="payment" value="${trade.payment}">
    </div>
    <div>
        <label>状态:</label>
        <select>
            <option></option>
            <option value="等待付款" name="s" <c:if test="${trade.status=='等待付款'}">selected="selected"</c:if>>等待付款</option>
            <option value="已经付款" name="s" <c:if test="${trade.status=='已经付款'}">selected="selected"</c:if>>已经付款</option>
            <option value="等待发货" name="s" <c:if test="${trade.status=='等待发货'}">selected</c:if>>等待发货</option>
            <option value="已发货" name="s" <c:if test="${trade.status=='已发货'}">selected="selected"</c:if>>已发货</option>
            <option value="交易成功" name="s" <c:if test="${trade.status=='交易成功'}">selected="selected"</c:if>>交易成功</option>
            <option value="退款中" name="s" <c:if test="${trade.status=='退款中'}">selected="selected"</c:if>>退款中</option>
        </select>
    </div>
    <div>
        <label>收货地址:</label>
        <input type="text" class="input-medium search-query" name="receiverAddress" value="${trade.receiverAddress}">
    </div>
    <div>
        <label>收货人电话:</label>
        <input type="text" class="input-medium search-query" name="receiverMobile" value="${trade.receiverMobile}">
    </div>
    <div>
        <label>收货人姓名:</label>
        <input type="text" class="input-medium search-query" name="receiverName" value="${trade.receiverName}">
    </div>
    <div>
        <label>备注:</label>
        <input type="text" class="input-medium search-query" name="sellerMemo" value="${trade.sellerMemo}">
    </div>
    <div>
        <label>手改金额:</label>
        <input type="text" class="input-medium search-query" name="discountFee" value="${trade.discountFee}">
    </div>
    <div id="last">
        <img src="../static/img/plus.png" onclick="plusRow()"/>
        <button onclick="update()">修改</button>
        <button onclick="cancel()">取消</button>
    </div>

</form>
</body>
</html>

<script>
    var count=0;
    $(function(){
        initOrder('${trade.id}')
    })


    function cancel(){
        parent.hideModel();
    }

    function initOrder(id){
        $.ajax({
            url:'${pageContext.request.contextPath}/order/tradeOrders',
            type:'post',
            dataType:'json',
            data:{id:id},
            success:function(data){
                addOrder(data);
            }
        })
    }

    function addOrder(data){
        var allItems=parent.ajaxSend('${pageContext.request.contextPath}/order/allItems',false,{});
        $(data).each(function(index,value){
            var div=$('<div></div>');
            var label=$('<label>商品'+eval(index+1)+'</label>');
            var select =$('<select class="num"></select>');
            $(allItems).each(function(i,v){
                var pro=v.propertiesNames;
                if(pro==null){
                    pro='';
                }else{
                    pro='-'+pro;
                }
                var option=$('<option value="'+v.id+'">'+v.title+pro+'</option>');
                if(value.numIid==v.id){
                    option.attr('selected','true');
                }
                select.append(option);
            })
            var num=$('<input type="number" value="'+value.num+'">');
            div.append(label).append(select).append(num);
            $('#last').before(div);
        })
        var modelHeight=parent.getModelHeight();
        var inputHeight=(25)*parseInt(data.length);
        parent.changeHeight(modelHeight+inputHeight);
        count=data.length+1;
    }

    function update(){
        var data=$('form').serialize();
        var status=$('form div:eq(3)>select').val();
        data+='&'+$.param({status:status});
        var items=$('select:gt(0)');
        var array=[];
        $(items).each(function(index,value){
            var item=new Object();
            item.id=$(this).val();
            var num=$(this).next().val();
            item.num=num;
            if(num<=0||item==null||$.trim(item.id)==''){
                return true;
            }
            array.push(item);
        })
        if(array.length==0){
            alert('商品不能为空');
            return;
        }

        var tid=$('input:eq(0)').val();
        $.ajax({
            url:'${pageContext.request.contextPath}/order/submitUpdate',
            data:data+'&param='+JSON.stringify(array)+'&tid='+tid,
            dataType:'text',
            type:'post',
            success:function (res) {
                if('true'==res){
                    parent.hideModel();
                    parent.myframe.init({query:JSON.stringify({tid:tid})});
                }else{
                    alert('修改失败')
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
        var num=$('<input type="number" value=1>');K
        var div=$('<div></div>')
        div.append(label).append(combo).append(num);
        $('#last').before(div);
        count++;
        var modelHeight=parent.getModelHeight();
        var inputHeight=num.height();
        parent.changeHeight(modelHeight+inputHeight+5);
    }
</script>
