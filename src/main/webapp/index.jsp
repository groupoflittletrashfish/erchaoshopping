<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        * {
            padding: 0px;
            margin: 0px;
        }

        #head {
            width: 100%;
            height: 50px;
            border-bottom: 1px solid red;
            line-height: 50px;
            background-color: #EDEDED;
        }

        #shoppingname {
            float: left;
            font-family: Consolas;
            margin-left: 50px;
            font-size: 30px;
            font-weight: bolder;
            color: #3a87ad;
            text-decoration: none;
        }

        #menuDetail {
            list-style: none;
            display: inline;
        }

        #menuDetail > li {
            float: left;
            margin-left: 10px;
            height: 50px;
        }

        #menus {
            display: inline;
            float: left;
            margin-left: 80px;
            font-family: Consolas;
            font-size: 18px;
        }

        li > a {
            display: inline-block;
            text-decoration: none;
            height: 100%;
        }

        li > a:hover {
            background-color: yellow;
        }

        ul {
            list-style: none;
        }

        ul li {
            font-weight: 800;
            position: relative;
        }

        ul li ul {
            display: none;
        }

        ul li ul li {
            background-color: #A7ADAD;
            display: block;
            width: inherit;
            text-align: center;
        }

        ul li:hover ul {
            display: block;
        }

        ul li ul li a {
            display: block;
            font-size: 15px;
        }

        ul li ul li:hover a {
            color: blue;
            font-weight: 900;
            /*text-shadow:1px 1px ;*/
        }

        #body {
            background-color: #EDEDED;
            /*border: 1px solid red;*/
            z-index: 1;
        }

        #myframe {
            width: 100%;
            padding: 5px;
            /*background-color: #449d44;*/
            /*border: 10px solid red;*/
        }

        #sha {
            position: fixed;
            border: 1px solid blue;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: 0.3;
            background-color: grey;
            z-index: 1;
        }

        #myModel > iframe {
            position: fixed;
            top: 50%;
            left: 50%;
            border: 0px;
            z-index: 2;
            box-shadow: 1px 1px 1px 1px black;
            opacity: 1;
        }

        #myModel {
            display: none;
        }


    </style>
    <script type="text/javascript" src="plugs/js/jquery-3.2.1.js"></script>
    <link rel="stylesheet" type="text/css" href="static/css/webuploader.css">
    <script type="text/javascript" src="static/js/webuploader.js"></script>
</head>


<body>

<%--<form action="http://localhost:8084/erchao/order/aaa" method="POST" enctype="multipart/form-data">--%>
    <%--<input type="file" multiple="multiple" name="files" />--%>
    <%--<br />--%>
    <%--<br />--%>
    <%--<input type="submit" value="提交" />--%>
<%--</form>--%>


<div id="head">
    <a id="shoppingname" href="javascript:void(0)">二超的小店</a>
    <div id="menus"></div>
</div>
<div id="body">
    <iframe name="myframe" id="myframe"></iframe>
</div>

<div id="myModel">
    <div id="sha"></div>
    <iframe src=""></iframe>
</div>
</body>
<script>
    $(function () {
        $('#myframe').height(parseInt($(document.body).height()) - 55);
        loadMainMenus();
    })


    function loadMainMenus() {
        var data = ajaxSend('${pageContext.request.contextPath}/menus/mainList', false);
        var ul = $('<ul id="menuDetail"></ul>');
        $(data).each(function (index, value) {
            var li = $('<li><a href="#">' + value.mainMenu.menuName + '</a></li>');
//            if(value.sonMenu!=null ){
            var sonUl = $('<ul></ul>');
            $(value.sonMenu).each(function (i, v) {
                var sonLi = $('<li><a href="javascript:void(0)" onclick="loadUrl(\'' + v.url + '\')">' + v.menuName + '</a></li>');
                sonUl.append(sonLi);
            })
            li.append(sonUl);
//            }
            ul.append(li);
            $('#menus').append(ul);
        })
    }


    function ajaxSend(url, async, param) {
        var result
        $.ajax({
            url: url,
            data: param,
            dataType: 'json',
            type: 'post',
            async: async,
            success: function (data) {
                result = data;

            }
        })
        return result;
    }

    function loadUrl(url) {
        $('#myframe').attr('src', url);
    }

    function newWin(width, height, url) {
        $('#myModel').show();
        $('#myModel>iframe').width(width + 'px');
        $('#myModel>iframe').height(height + 'px');
        $('#myModel>iframe').css('margin-left', parseInt(width) / 2 * (-1));
        $('#myModel>iframe').css('margin-top', parseInt(height) / 2 * (-1));
        $('#myModel>iframe').attr('src', url);
    }


    function hideModel() {
        $('#myModel').hide();
        $('#myModel>iframe').attr('src', '');
    }

    function changeHeight(height) {
        $("#myModel>iframe").animate({
            height: height,
            marginTop: parseInt(height) / 2 * (-1)
        }, 'slow');
    }

    function getMyFrameHeight() {
        return $('#myframe').height();
    }

    function getModelHeight() {
        return $('#myModel>iframe').height();

    }


</script>
</html>