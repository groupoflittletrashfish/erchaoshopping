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
            /*overflow: hidden;*/
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

        li > input {
            opacity: 0.5;
        }

        #side img {
            width: 20px;
            height: 20px;
            position: absolute;
            top: 40%;
            right: 310px;
        }

        ul{
            list-style: none;
        }

        ul li{
            margin-top:10px;
        }

    </style>

</head>
<body>
<table id="table"></table>
<div id="side">
    <img src="../static/img/shouqi.png" onclick="show()"/>
    <ul>
        <li>
            <label>快速查询:</label>
            <input type="text" name="search">
        </li>
        <li>
            <label>条件查询:</label>
            <input type="text" name="condition">
        </li>
    </ul>
</div>
</body>
</html>

<script>
    $(function () {
        $('#table').bootstrapTable({
            url: '${pageContext.request.contextPath}/order/orderList',
            height: $(document.body).height() - 70,
            striped: true,
            cache: false,
            local: '',
            pagination: true,
            queryParams: getQueryParams,
            queryParamsType: 'limit',
            sidePagination: 'server',
            paginationVAlign: 'bottom',
            paginationDetailHAlign: 'right',
            paginationHAlign: 'right',
            columns: [
                {
                    checkbox: true
                }, {
                    field: 'orderNum',
                    title: '订单号(order_num)',
                    formatter:function(value,row){
                        return '<a href="javascript:void(0)" onclick="updateOrder(\''+row.id+'\')">'+value+'</a>';
                    }
                }, {
                    field: 'wangwang',
                    title: '旺旺号(wangwang)'
                }, {
                    field: 'address',
                    title: '地址(address)'
                }, {
                    field: 'realityPay',
                    title: '实付金额(reality_pay)'
                }, {
                    field: 'createTime',
                    title: '创建时间(create_time)',
                    formatter:function(value){
                        var year=eval(value.year+1900);
                        var month=eval(value.month+1)>9?eval(value.month+1):'0'+eval(value.month+1);
                        var date=eval(value.date)>9?eval(value.date):'0'+eval(value.date);
                        var hours=eval(value.hours)>9?eval(value.hours):'0'+eval(value.hours);
                        var minutes=eval(value.minutes)>9?eval(value.minutes):'0'+eval(value.minutes);
                        var seconds=eval(value.seconds)>9?eval(value.seconds):'0'+eval(value.seconds);
                        return year+'-'+month+'-'+date+' '+hours+':'+minutes+':'+seconds;
                    }
                }
            ]
        });


        //查询框绑定回车事件
        $('input').keyup(function(event){
            if(event.keyCode==13){
                var query=$(this).val().trim();
                var type=$(this).attr('name');

                    $('#table').bootstrapTable('refresh',{silent: true,query:{query:query,type:type}});


            }
        })

    })


    function getQueryParams(params) {
        var par = {
            limit: params.limit,
            offset: params.offset,
        }
        return par;
    }

    function show() {
        if ($('#side').attr('complete')=='true') {
            $("#side").animate({
                right: -300
            }, "slow");
            $('#side').attr('complete','');
        } else {
            $("#side").animate({
                right: 0
            }, "slow");
            $('#side').attr('complete', true);
        }
    }

    function updateOrder(id){
        parent.newWin(300,250,'${pageContext.request.contextPath}/order/toUpdateOrder?id='+id);
    }


</script>
