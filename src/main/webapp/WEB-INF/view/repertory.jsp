<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: noname
  Date: 2017/11/23
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="../plugs/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="../plugs/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../plugs/js/bootstrap-table.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../static/css/bootstrap-table.min.css">

    <title>Repertory</title>
    <style>
        * {
            padding: 0px;
            margin: 0px;
            font-family: Consolas;
            font-size: small;
        }

        table {
            width: 95%;
            text-align: center;
            margin-bottom: 10px;
        }

        tr {
            line-height: 30px;
        }

        tr:first-of-type {
            background-color: #603000;
            color: white;
        }

        input {
            width: 100%;
            border: 0px;
            text-align: center;
        }

        input:hover {
            background-color: yellow;
        }

        input[type=checkbox] {
            width: 20px;
        }
    </style>
</head>
<body>
<label>库存数据预览</label>
<table border="1">
    <tr id="title">
        <td><input type="checkbox" onclick="chooseAll()"></td>
        <td>商品</td>
        <td>属性</td>
        <td>库存数</td>
        <td>单价</td>
        <td>~</td>
    </tr>
</table>
</body>
</html>


<script>
    //获得焦点时暂存的数据
    var beforeData

    $(function () {
        //数据初始化
        var result = parent.ajaxSend("items/allItems", false)
        $(result).each(function (index, value) {
            var pro = value.propertiesNames;
            if (pro == null) {
                pro = '';
            }
            var tr = $('<tr id="' + value.id + '"><td><input type="checkbox"></td><td><input type="text" col="title" value="' + value.title + '"/></td><td><input type="text" col="properties_names" value="' + pro + '"/</td>' +
                '<td><input type="text" col="repertory" value="' + value.repertory + '"/</td><td><input type="text" col="price" value="' + value.price + '"/</td><td><a href="javascript:void(0)">删除</a></td></tr>');
            if (index % 2 == 1) {
                tr.find('input').css('background-color', '#D8EBEF');
                tr.find('td').css('background-color', '#D8EBEF')
            }
            $('table').append(tr);
        })


        //数据添加blur事件
        $('tr:gt(0) td input').on('blur', function () {
            if (beforeData != $.trim($(this).val())) {
                var id = $(this).parents('tr').attr('id');
                var attr = $(this).attr('col');

                switch (attr) {
                    case 'title':
                        console.log('title');
                        break;
                    case 'properties_names':
                        console.log('properties_names');
                        break;
                    case 'repertory':
                        verifyRepertory(this, id);
                        break;
                    case 'price':
                        console.log('price');
                        break;
                }

            }
        })

        //获得焦点时候暂时记录该数据
        $('tr:gt(0) td input').on('focus', function () {
            beforeData = $(this).val();
        })

        //当所有checkbox被选中时，第一个checkbox也被选中，反之亦然
        $('input[type=checkbox]:gt(0)').on('click', function () {
            var isAllClosed = 0;
            var isAllSelected = 0;
            var allCheck = $('input[type=checkbox]:gt(0)');
            $(allCheck).each(function (index, value) {
                if ($(this).is(':checked')) {
                    isAllSelected++;
                } else {
                    isAllClosed++;
                }
            })
            if (isAllClosed == allCheck.length) {
                $('input[type=checkbox]:first').prop('checked', false);
            }
            if (isAllSelected == allCheck.length) {
                $('input[type=checkbox]:first').prop('checked', true);
            }
        })

    })

    //全选事件和全部移除事件
    function chooseAll() {
        if ($('input[type=checkbox]:first').is(':checked')) {
            $('input[type=checkbox]').prop('checked', true);
        } else {
            $('input[type=checkbox]').prop('checked', false);
        }
    }

    function verifyRepertory(ele, id) {
        var value = $(ele).val();
        if (!/^\d+$/.test(value)) {
            swal('必须是整数');
            return;
        }
        swal({
            title:'数据已经更新',
            text:'修改完成',
            type:'success',
            showCancelButton:true,
            cancelButtonText: "取消ge！",
        });
    }


</script>

